FROM node:22

# Eliminar Yarn para evitar conflicto
RUN npm uninstall -g yarn || true

# Instalar pnpm en la versión específica
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
