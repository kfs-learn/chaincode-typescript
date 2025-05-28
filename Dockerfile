FROM node:18-slim

# Install bun
RUN apt-get update && apt-get install -y curl unzip && \
    curl -fsSL https://bun.sh/install | bash && \
    ln -s /root/.bun/bin/bun /usr/local/bin/bun

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies using bun
RUN bun install

# Copy source code
COPY . .

# Build TypeScript
RUN bun run build

# Expose port for chaincode server
EXPOSE 9090

# Start development server
CMD ["bun", "run", "start:dev"]
