# Stage 1: Build with Bun
FROM oven/bun:1-debian AS build

WORKDIR /app

# Install necessary build tools
RUN apt-get update && apt-get install -y python3 make g++

# Copy package.json and bun.lock (if available)
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy the rest of the source code
COPY . .

# Build the application
RUN bun run build

# Stage 2: Run the app with Node
FROM node:22-alpine

WORKDIR /app

# Install Bun globally
RUN npm install -g bun

# Copy package files for bun install
COPY --from=build /app/package.json /app/bun.lock* ./

# Install production dependencies with bun
RUN bun install --production

# Copy built files from the build stage
COPY --from=build /app/dist ./dist

ENV HOST=0.0.0.0
ENV PORT=4321

EXPOSE 4321

# Command to run the application with Bun
CMD ["node", "./dist/server/entry.mjs"]
