#!/bin/bash
set -e
DEPLOY_DIR=~/deploy/crud-mean-app
REPO=https://github.com/AnuPriya2k1/DevOps-Intern-assignment-Full-Stack-Mean-application.git
BRANCH=main

mkdir -p \"\"
cd \"\"

if [ -d .git ]; then
  git fetch --all
  git reset --hard origin/\
else
  rm -rf ./*
  git clone --single-branch --branch \ \"\" .
fi

docker compose pull || true
docker compose up -d --remove-orphans --build
