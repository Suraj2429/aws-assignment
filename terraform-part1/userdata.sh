#!/bin/bash

apt update -y
apt install -y python3-pip python3-venv git curl

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

cd /home/ubuntu

# Clone your repo
git clone https://github.com/Suraj2429/aws-assignment.git

cd aws-assignment/backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
nohup python3 app.py &

cd ../frontend
npm install
nohup node server.js &xd