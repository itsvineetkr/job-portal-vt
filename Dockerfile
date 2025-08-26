# Stage 1: Build the frontend
FROM node:18-alpine AS frontend
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json* ./
RUN npm install --legacy-peer-deps
COPY frontend/. .
RUN npm run build

# Stage 2: Setup the backend
FROM node:18-alpine
WORKDIR /app
COPY backend/package.json backend/package-lock.json* ./
RUN npm install
COPY backend/. .
COPY --from=frontend /app/frontend/build ./public

EXPOSE 4444
CMD ["node", "server.js"]
