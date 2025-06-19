# Usa Node 22, que ya incluye Corepack
FROM node:22

# Habilitar corepack para que funcione el campo "packageManager"
RUN corepack enable

# Instala la versión correcta de pnpm definida en package.json
RUN corepack prepare pnpm@10.12.1 --activate

# Configurar entorno de pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV PNPM_LOG_LEVEL=debug

# Directorio de trabajo
WORKDIR /app

# Copia el proyecto
COPY . .

# Instala las dependencias del monorepo
RUN pnpm install --frozen-lockfile=false

# Compila el proyecto
RUN pnpm build

# Puerto por defecto de n8n
EXPOSE 5678

# Comando para iniciar n8n
CMD ["pnpm", "start:default"]
