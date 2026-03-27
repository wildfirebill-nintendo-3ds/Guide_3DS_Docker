# Stage 1: Build the VitePress documentation
FROM node:20-alpine AS build

RUN apk add --no-cache git

WORKDIR /app

# Copy package files first for better layer caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the project including .git and docs
COPY . .

# Initialize the theme submodule
RUN git submodule update --init --recursive

# Build the VitePress site
RUN npm run docs:build

# Stage 2: Serve with nginx
FROM nginx:stable-alpine

# Remove default nginx config and content
RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built assets from the build stage
COPY --from=build /app/docs/.vitepress/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
