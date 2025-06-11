# Build stage
FROM node:18-alpine as build-step

WORKDIR /app

COPY package*.json ./
RUN pnpm install

COPY . .
RUN pnpm run build

# Production stage
FROM nginx:1.23-alpine

COPY --from=build-step /app/dist /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
