# Use official Node.js image for multi-stage build
FROM node:18-alpine AS backend
WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install
COPY backend/. .

FROM node:18-alpine AS frontend
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend/. .

# Final image for running containers
FROM node:18-alpine AS final
WORKDIR /app

# Copy backend build
COPY --from=backend /app/backend ./backend
# Copy frontend build
COPY --from=frontend /app/frontend ./frontend

# Expose ports for both services
EXPOSE 4444 3000

# Default command (can be overridden in docker-compose)
CMD ["sh"]
