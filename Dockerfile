# Dockerfile
# 1. Build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
ARG VITE_FRIGATE_API_URL
ARG VITE_CAMERA_NAMES
ARG VITE_CAMERA_RES
RUN VITE_FRIGATE_API_URL=${VITE_FRIGATE_API_URL} VITE_CAMERA_NAMES=${VITE_CAMERA_NAMES} VITE_CAMERA_RES=${VITE_CAMERA_RES} npm run build

# 2. Serve stage
FROM nginx:stable-alpine AS server

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
