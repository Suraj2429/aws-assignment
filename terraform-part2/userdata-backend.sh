#!/bin/bash

apt update -y
apt install -y python3-pip python3-venv git

cd /home/ubuntu
git clone https://github.com/Suraj2429/aws-assignment.git

cd aws-assignment/backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
nohup python3 app.py &