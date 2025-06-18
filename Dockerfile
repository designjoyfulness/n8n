FROM node:22

RUN npm install -g pnpm@10.12.1

WORKDIR /app

COPY . .

RUN pnpm install

RUN pnpm build

EXPOSE 5678

CMD ["pnpm", "start:default"]
