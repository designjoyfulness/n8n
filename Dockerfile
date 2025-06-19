FROM node:22

# Activa Corepack para usar pnpm
RUN corepack enable
RUN corepack prepare pnpm@10.12.1 --activate

# Variables de entorno necesarias
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV PNPM_LOG_LEVEL=debug

# Carpeta de trabajo
WORKDIR /app

# Copiar todos los archivos
COPY . .

# Instalar dependencias y compilar el proyecto
RUN pnpm install --frozen-lockfile=false
RUN pnpm build

# Exponer el puerto donde corre n8n
EXPOSE 5678

# Comando que arranca n8n
CMD ["pnpm", "start:default"]
