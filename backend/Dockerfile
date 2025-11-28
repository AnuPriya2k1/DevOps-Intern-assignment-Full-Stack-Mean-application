# backend/Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY . .
ENV PORT=3000
EXPOSE 3000
ENV MONGO_URI="mongodb://root:examplepassword@mongo:27017/mean_db?authSource=admin"
ENV MONGODB_URI=
CMD ["node", "server.js"]
