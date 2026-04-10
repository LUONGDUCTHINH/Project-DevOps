# --- Stage 1: Builder ---
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .


# --- Stage 2: Production ---
FROM node:18-alpine

WORKDIR /app

# Copy package.json và cài production deps
COPY package*.json ./
RUN npm install --production

# Copy code từ builder
COPY --from=builder /app ./

# Mở port
EXPOSE 3000

# Run app
CMD ["npm", "start"]
