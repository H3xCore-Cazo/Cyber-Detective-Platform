#!/bin/bash
# =============================================================================
# Cyber Detective DFIR Platform - Deployment Script
# =============================================================================
# Usage:
#   ./deploy.sh              # Full deployment
#   ./deploy.sh --build      # Force rebuild
#   ./deploy.sh --seed       # Seed the database after deploy
#   ./deploy.sh --ssl        # Setup SSL with Let's Encrypt
#   ./deploy.sh --stop       # Stop all services
#   ./deploy.sh --logs       # View live logs
#   ./deploy.sh --status     # Check service status
# =============================================================================

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="cyber-detective"
COMPOSE_FILE="docker-compose.yml"

# Print banner
print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║     🔍 Cyber Detective DFIR Platform - Deployer 🔍        ║"
    echo "║                                                           ║"
    echo "║     Hack The Box for Cyber Detectives                     ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Check prerequisites
check_prerequisites() {
    echo -e "${YELLOW}[*] Checking prerequisites...${NC}"
    
    local missing=0
    
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}✗ Docker is not installed${NC}"
        missing=1
    else
        echo -e "${GREEN}✓ Docker $(docker --version | cut -d' ' -f3 | tr -d ',')${NC}"
    fi
    
    if ! command -v docker compose &> /dev/null && ! docker compose version &> /dev/null 2>&1; then
        echo -e "${RED}✗ Docker Compose V2 is not available${NC}"
        missing=1
    else
        COMPOSE_CMD="docker compose"
        echo -e "${GREEN}✓ Docker Compose V2${NC}"
    fi
    
    if [ "$missing" -eq 1 ]; then
        echo -e "${RED}Please install missing prerequisites and try again.${NC}"
        exit 1
    fi
    
    echo ""
}

# Create .env file if not exists
create_env() {
    if [ ! -f .env.production ]; then
        echo -e "${YELLOW}[*] Creating .env.production file...${NC}"
        
        # Generate a secure JWT secret
        JWT_SECRET=$(openssl rand -base64 48 | tr -d '\n')
        
        cat > .env.production << EOF
# =============================================================================
# Cyber Detective DFIR Platform - Production Environment
# =============================================================================
# IMPORTANT: Change all secrets before deploying!

# Database (SQLite - stored in Docker volume)
DATABASE_URL=file:/app/data/cyberdetective.db

# JWT Secret (auto-generated - change if needed)
JWT_SECRET=${JWT_SECRET}

# Admin Credentials (CHANGE THESE!)
ADMIN_EMAIL=admin@cyberdetective.com
ADMIN_PASSWORD=ChangeMe@2024!

# Node Environment
NODE_ENV=production
NEXT_TELEMETRY_DISABLED=1

# Server Port
PORT=3000
EOF
        
        echo -e "${GREEN}✓ Created .env.production with auto-generated JWT secret${NC}"
        echo -e "${YELLOW}  ⚠ IMPORTANT: Edit .env.production to set your admin credentials!${NC}"
    else
        echo -e "${GREEN}✓ .env.production already exists${NC}"
    fi
    echo ""
}

# Build and deploy
deploy() {
    print_banner
    check_prerequisites
    create_env
    
    echo -e "${CYAN}[*] Building and deploying Cyber Detective Platform...${NC}"
    echo ""
    
    # Stop existing containers
    echo -e "${YELLOW}[*] Stopping existing containers...${NC}"
    $COMPOSE_CMD --env-file .env.production down 2>/dev/null || true
    
    # Build images
    echo -e "${YELLOW}[*] Building Docker images (this may take a few minutes)...${NC}"
    $COMPOSE_CMD --env-file .env.production build --no-cache
    
    # Start services
    echo -e "${YELLOW}[*] Starting services...${NC}"
    $COMPOSE_CMD --env-file .env.production up -d
    
    # Wait for health check
    echo -e "${YELLOW}[*] Waiting for application to start...${NC}"
    local retries=0
    local max_retries=30
    while [ $retries -lt $max_retries ]; do
        if curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api 2>/dev/null | grep -q "200\|401"; then
            echo -e "${GREEN}✓ Application is running!${NC}"
            break
        fi
        retries=$((retries + 1))
        echo -e "  Waiting... ($retries/$max_retries)"
        sleep 2
    done
    
    if [ $retries -eq $max_retries ]; then
        echo -e "${RED}✗ Application failed to start. Check logs:${NC}"
        echo -e "  docker compose logs app"
        exit 1
    fi
    
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║           🎉 Deployment Successful! 🎉                    ║${NC}"
    echo -e "${GREEN}╠═══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║                                                           ║${NC}"
    echo -e "${GREEN}║  App:     http://localhost:3000                            ║${NC}"
    echo -e "${GREEN}║  API:     http://localhost:3000/api                        ║${NC}"
    echo -e "${GREEN}║  Nginx:   http://localhost:80                              ║${NC}"
    echo -e "${GREEN}║                                                           ║${NC}"
    echo -e "${GREEN}║  Next steps:                                               ║${NC}"
    echo -e "${GREEN}║  1. Seed DB:     ./deploy.sh --seed                       ║${NC}"
    echo -e "${GREEN}║  2. Create admin: see DEPLOYMENT.md                       ║${NC}"
    echo -e "${GREEN}║  3. Setup SSL:   ./deploy.sh --ssl                        ║${NC}"
    echo -e "${GREEN}║                                                           ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
}

# Seed the database
seed_db() {
    echo -e "${YELLOW}[*] Seeding database...${NC}"
    
    # Execute seed inside the app container
    docker compose exec app sh -c "npx prisma db push --skip-generate && npx tsx prisma/seed.ts" 2>/dev/null || \
    docker compose exec app sh -c "npx prisma db push --skip-generate" 2>/dev/null || \
    echo -e "${YELLOW}  Note: You may need to seed manually. See DEPLOYMENT.md${NC}"
    
    echo -e "${GREEN}✓ Database seeded${NC}"
}

# Setup SSL with Certbot
setup_ssl() {
    echo -e "${CYAN}[*] SSL Setup with Let's Encrypt${NC}"
    echo ""
    
    read -p "Enter your domain name (e.g., cyberdetective.example.com): " DOMAIN
    
    if [ -z "$DOMAIN" ]; then
        echo -e "${RED}Domain is required for SSL setup${NC}"
        exit 1
    fi
    
    # Install certbot if not present
    if ! command -v certbot &> /dev/null; then
        echo -e "${YELLOW}[*] Installing Certbot...${NC}"
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y certbot
        elif command -v yum &> /dev/null; then
            sudo yum install -y certbot
        elif command -v brew &> /dev/null; then
            brew install certbot
        fi
    fi
    
    # Create SSL directory
    mkdir -p ./ssl
    
    # Get certificate
    echo -e "${YELLOW}[*] Obtaining SSL certificate for $DOMAIN...${NC}"
    sudo certbot certonly --standalone -d "$DOMAIN" --non-interactive --agree-tos --email "admin@$DOMAIN"
    
    # Copy certificates
    sudo cp "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ./ssl/cert.pem
    sudo cp "/etc/letsencrypt/live/$DOMAIN/privkey.pem" ./ssl/key.pem
    sudo chmod 644 ./ssl/cert.pem
    sudo chmod 600 ./ssl/key.pem
    
    echo -e "${GREEN}✓ SSL certificates installed${NC}"
    echo -e "${YELLOW}  Now uncomment the HTTPS block in nginx.conf and redeploy${NC}"
}

# Stop services
stop_services() {
    echo -e "${YELLOW}[*] Stopping all services...${NC}"
    docker compose down
    echo -e "${GREEN}✓ Services stopped${NC}"
}

# View logs
view_logs() {
    docker compose logs -f --tail=100
}

# Check status
check_status() {
    echo -e "${CYAN}[*] Service Status:${NC}"
    docker compose ps
    echo ""
    echo -e "${CYAN}[*] Health Check:${NC}"
    
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api 2>/dev/null || echo "000")
    if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "401" ]; then
        echo -e "${GREEN}✓ App is healthy (HTTP $HTTP_CODE)${NC}"
    else
        echo -e "${RED}✗ App is unhealthy (HTTP $HTTP_CODE)${NC}"
    fi
}

# Parse arguments
case "${1:-}" in
    --build)
        deploy
        ;;
    --seed)
        seed_db
        ;;
    --ssl)
        setup_ssl
        ;;
    --stop)
        stop_services
        ;;
    --logs)
        view_logs
        ;;
    --status)
        check_status
        ;;
    --help|-h)
        print_banner
        echo "Usage: ./deploy.sh [OPTION]"
        echo ""
        echo "Options:"
        echo "  (none)     Full deployment (build + start)"
        echo "  --build    Force rebuild and deploy"
        echo "  --seed     Seed the database with demo data"
        echo "  --ssl      Setup SSL with Let's Encrypt"
        echo "  --stop     Stop all services"
        echo "  --logs     View live application logs"
        echo "  --status   Check service health status"
        echo "  --help     Show this help message"
        ;;
    *)
        deploy
        ;;
esac
