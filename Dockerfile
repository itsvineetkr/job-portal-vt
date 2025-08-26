# Stage 1: Build the frontend
FROM node:18-alpine
WORKDIR /app
RUN npm install -g concurrently
COPY frontend/package.json frontend/package-lock.json* ./frontend/
RUN cd frontend && npm install --legacy-peer-deps
COPY backend/package.json backend/package-lock.json* ./backend/
RUN cd backend && npm install
COPY frontend/. ./frontend
COPY backend/. ./backend
EXPOSE 3000
CMD ["concurrently", "npm:start --prefix frontend", "npm:start --prefix backend"]
