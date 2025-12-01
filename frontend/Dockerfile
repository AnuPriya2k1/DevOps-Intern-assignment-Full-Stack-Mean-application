FROM node:20-bullseye AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npx -y @angular/cli@latest build --configuration production

FROM nginx:stable-alpine
COPY --from=builder /app/dist/angular-15-crud /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
