# Multi-stage Dockerfile for Fido SBA Copilot

# Stage 1: Build backend
FROM node:18-alpine AS backend-builder

WORKDIR /app/backend

# Copy backend package files
COPY backend/package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy backend source code
COPY backend/ ./

# Stage 2: Prepare frontend
FROM nginx:alpine AS frontend-builder

# Copy frontend files
COPY frontend/ /usr/share/nginx/html/

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Stage 3: Final image
FROM node:18-alpine

# Install nginx for serving frontend
RUN apk add --no-cache nginx

# Create app directory
WORKDIR /app

# Copy backend from builder stage
COPY --from=backend-builder /app/backend ./backend

# Copy frontend files
COPY --from=frontend-builder /usr/share/nginx/html ./frontend
COPY --from=frontend-builder /etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Create nginx directories
RUN mkdir -p /var/log/nginx /var/lib/nginx/tmp

# Expose ports
EXPOSE 3000 80

# Create startup script
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'nginx &' >> /app/start.sh && \
    echo 'cd /app/backend && node index.js' >> /app/start.sh && \
    chmod +x /app/start.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start both services
CMD ["/app/start.sh"]