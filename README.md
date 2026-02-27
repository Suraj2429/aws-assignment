# 🚀 CI/CD Deployment Assignment  
### Flask Backend + Express Frontend + Jenkins on AWS EC2

---

## 📌 Project Overview

This project demonstrates a complete CI/CD pipeline implementation using:

- 🐍 Flask (Backend)
- 🌐 Express.js (Frontend)
- ⚙ Jenkins (CI/CD Automation)
- ☁ AWS EC2 (Deployment Server)
- 🔁 GitHub Webhook (Automation Trigger)
- 🔄 systemd (Process Management)

Both applications are deployed on a single EC2 instance and automatically redeployed on every GitHub push using Jenkins.

---

## 🏗 Architecture Overview
Developer → GitHub Push
↓
GitHub Webhook
↓
Jenkins (EC2)
↓
Pull Latest Code
↓
Install Dependencies
↓
Restart systemd Services
↓
Flask (5000) + Express (3000)


---

## ☁ AWS EC2 Setup

- Launched Ubuntu EC2 instance (Free Tier)
- Opened required ports:
  - 22 (SSH)
  - 8080 (Jenkins)
  - 5000 (Flask)
  - 3000 (Express)

Installed dependencies:

``bash
sudo apt update
sudo apt install python3 python3-venv python3-pip nodejs npm git -y

---

## 🐍 Backend Deployment (Flask)
1️⃣ Clone Repository
git clone https://github.com/Suraj2429/aws-assignment.git
cd aws-assignment/backend

2️⃣ Create Virtual Environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
deactivate

3️⃣ Create systemd Service
/etc/systemd/system/flask-backend.service

[Unit]
Description=Flask Backend Service
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/aws-assignment/backend
ExecStart=/home/ubuntu/aws-assignment/backend/venv/bin/python /home/ubuntu/aws-assignment/backend/app.py
Restart=always
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target

# Start service:

sudo systemctl daemon-reload
sudo systemctl enable flask-backend
sudo systemctl start flask-backend

# Backend runs on:
http://<EC2-PUBLIC-IP>:5000

---

##🌐 Frontend Deployment (Express)
1️⃣ Install Dependencies
cd aws-assignment/frontend
npm install
2️⃣ Create systemd Service

/etc/systemd/system/express-frontend.service

[Unit]
Description=Express Frontend Service
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/aws-assignment/frontend
ExecStart=/usr/bin/node /home/ubuntu/aws-assignment/frontend/server.js
Restart=always
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target

Start service:

sudo systemctl daemon-reload
sudo systemctl enable express-frontend
sudo systemctl start express-frontend

Frontend runs on:
http://<EC2-PUBLIC-IP>:3000

---

## 🔔 GitHub Webhook Configuration

Webhook URL:
http://<EC2-PUBLIC-IP>:8080/github-webhook/

---

## 📸 Screenshots & Detailed Evidence

Complete screenshots and step-by-step explanation are available here:

👉 Documentation Link:
https://docs.google.com/document/d/1vxeXPJR0DYstGSHByTgm4IjAOT7MsiKcvDXonzpN8vY/edit?usp=sharing
