# Base image oficial do Bun
FROM oven/bun:latest AS base
WORKDIR /app

# Copia os arquivos de dependências
COPY package.json bun.lockb* ./

FROM base AS dev
# O Makefile gerencia o install via volumes, mas deixamos o COPY para o código
COPY . .

EXPOSE 3000
# CMD ["bun", "run", "dev", "--port", "3000"]
CMD ["bun", "run", "dev"]