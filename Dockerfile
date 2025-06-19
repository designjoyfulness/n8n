FROM node:22

# Variables para que pnpm se instale correctamente y dé logs detallados
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
ENV PNPM_LOG_LEVEL=debug

# Instalar pnpm
RUN npm install -g pnpm@10.12.1

# Carpeta del proyecto
WORKDIR /app

# Copiar todos los archivos del proyecto
COPY . .

# Instalar dependencias, aunque haya diferencias en lockfile
RUN pnpm install --frozen-lockfile=false

# Compilar el proyecto
RUN pnpm build

# Puerto que usa n8n
EXPOSE 5678

# Iniciar n8n
CMD ["pnpm", "start:default"]
