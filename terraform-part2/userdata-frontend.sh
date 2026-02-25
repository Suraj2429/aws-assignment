#!/bin/bash

apt update -y
apt install -y git curl

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

cd /home/ubuntu
git clone https://github.com/Suraj2429/aws-assignment.git

cd aws-assignment/Frontend

# Replace backend URL dynamically
sed -i "s|http://localhost:5000|http://${backend_ip}:5000|g" server.js

npm install
nohup node server.js &