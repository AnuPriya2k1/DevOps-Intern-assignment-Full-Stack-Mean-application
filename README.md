# DevOps Assignment - MEAN App (Auto-generated files)

This repository contains a fully containerized MEAN (MongoDB, Express, Angular, Node.js) CRUD application deployed on an AWS EC2 Ubuntu Server, fronted by Nginx, and automated with a full GitHub Actions CI/CD pipeline.

The entire stack is deployed using Docker Compose with production-ready configurations.

🏗️ Architecture Overview
User → Nginx (Port 80)
        ├── Serves Angular Frontend (dist/)
        └── Proxies /api → Node.js Backend (Port 3000)
                            └── Connects to MongoDB (Port 27017)

📁 Repository Structure
.
├── backend/                 # Node.js + Express API
│   └── Dockerfile
├── frontend/                # Angular App
│   └── Dockerfile
├── deploy/
│   └── default.conf         # Nginx reverse proxy config
├── docker-compose.yml       # Multi-container deployment
└── .github/workflows/
    └── ci-cd.yml            # CI/CD workflow (Docker + SSH deploy)

🚀 Features

✔ Production-ready containerized MEAN stack
✔ Automated CI pipeline (Docker build + push)
✔ Automated CD (SSH deploy to EC2)
✔ Nginx reverse proxy on port 80
✔ MongoDB running as a service
✔ Fully repeatable deployment using Docker Compose
✔ Secure GitHub Secrets usage

🛠️ Prerequisites
On EC2 Ubuntu Instance:

Docker

Docker Compose Plugin

SSH access enabled

In GitHub Repository → Settings → Secrets:

Set the following:

Secret Name	Purpose
DOCKERHUB_USERNAME	Docker Hub username
DOCKERHUB_TOKEN	Docker Hub PAT (for CI image push)
VM_HOST	EC2 public IP
VM_SSH_PRIVATE_KEY	EC2 private key for deploy
VM_SSH_USER	Normally ubuntu
🔧 Docker Compose Deployment (Manual)

SSH into EC2 and run:

cd ~/crud-mean-app
docker compose pull
docker compose up -d


Check running containers:

docker compose ps


View logs:

docker compose logs nginx --tail 50


Open the app in browser:

http://EC2_PUBLIC_IP/

🧱 Docker Compose File Summary

The application consists of 4 services:

mongodb → Database

backend → Node.js REST API

frontend → Angular UI served through Nginx

nginx → Reverse proxy + static file server

Key settings:

frontend & backend images pulled from Docker Hub

MongoDB credentials defined

Nginx routing /api → backend:3000

🌐 Nginx Reverse Proxy Configuration

Location: deploy/default.conf

server {
    listen 80;

    location /api/ {
        proxy_pass http://backend:3000/;
    }

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}

🔄 CI/CD Pipeline (GitHub Actions)

Located at:

.github/workflows/ci-cd.yml

The pipeline performs:
1️⃣ Build Phase

Checkout repository

Login to Docker Hub

Build frontend image

Build backend image

Push both to Docker Hub

2️⃣ Deploy Phase

Use SSH private key from GitHub Secrets

Login to EC2

Pull latest images

Restart containers

Verify running services

Runs automatically on every push to main.
🧪 Testing the Application
Test Nginx:
curl -I http://localhost


Expected:

HTTP/1.1 200 OK

Test backend API:
curl http://localhost/api/users

MongoDB:
docker exec -it <mongodb-container> mongosh -u root -p examplepassword
