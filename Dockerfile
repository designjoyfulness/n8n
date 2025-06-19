FROM node:22

# Habilitar Corepack para manejar pnpm/yarn según packageManager
RUN corepack enable

# Instalar pnpm versión especificada (Corepack lo gestionará pero instalamos explícito)
RUN npm install -g pnpm@10.12.1

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV PNPM_LOG_LEVEL=debug

WORKDIR /app

COPY . .

RUN pnpm install --frozen-lockfile=false

RUN pnpm build

EXPOSE 5678

CMD ["pnpm", "start:default"]
