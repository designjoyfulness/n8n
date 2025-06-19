FROM node:22

# Habilita Corepack antes de que Render lea el packageManager
RUN corepack enable

# Prepara e instala la versión de pnpm definida en package.json
RUN corepack prepare pnpm@10.12.1 --activate

# Configurar entorno
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV PNPM_LOG_LEVEL=debug

# Directorio de trabajo
WORKDIR /app

# Copiar todo el proyecto
COPY . .

# Instalar dependencias sin bloquear por diferencias en lockfile
RUN pnpm install --frozen-lockfile=false

# Compilar el monorepo (incluye backend y frontend)
RUN pnpm build

# Exponer puerto por defecto de n8n
EXPOSE 5678

# Comando para iniciar n8n
CMD ["pnpm", "start:default"]
