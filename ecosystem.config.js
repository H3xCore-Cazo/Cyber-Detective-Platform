// =============================================================================
// Cyber Detective DFIR Platform - PM2 Ecosystem Config
// =============================================================================
// Usage: pm2 start ecosystem.config.js
// Docs: https://pm2.keymetrics.io/docs/usage/application-declaration/
// =============================================================================

module.exports = {
  apps: [
    {
      name: 'cyber-detective',
      
      // Next.js standalone server
      script: '.next/standalone/server.js',
      
      // Environment variables
      env: {
        NODE_ENV: 'production',
        PORT: 3000,
        HOSTNAME: '0.0.0.0',
        DATABASE_URL: 'file:./data/cyberdetective.db',
      },
      
      // Process management
      instances: 1,            // Single instance for SQLite (not cluster-safe)
      autorestart: true,       // Auto restart on crash
      max_memory_restart: '1G', // Restart if memory exceeds 1GB
      
      // Logging
      error_file: './logs/error.log',
      out_file: './logs/out.log',
      merge_logs: true,
      time: true,
      
      // Graceful shutdown
      kill_timeout: 5000,
      listen_timeout: 30000,
      
      // Health monitoring
      min_uptime: '10s',
      max_restarts: 10,
      restart_delay: 4000,
    }
  ]
};
