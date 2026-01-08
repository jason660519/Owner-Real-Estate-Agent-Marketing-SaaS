# Use official Node.js image
FROM node:18-alpine

WORKDIR /app

# Install dependencies (Caching layer)
COPY package.json package-lock.json* ./
RUN npm install

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Start development server
CMD ["npm", "run", "dev"]
