FROM oven/bun:latest AS base
WORKDIR /app
COPY package.json bun.lockb* ./

FROM base AS dev
COPY . .
EXPOSE 3000
CMD ["bun", "run", "dev"]