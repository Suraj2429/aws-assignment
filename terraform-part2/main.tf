provider "aws" {
  region = var.aws_region
}

# -----------------------------
# Backend Security Group
# -----------------------------
resource "aws_security_group" "backend_sg" {
  name = "backend-sg"

  ingress {
    description = "Allow Flask from Frontend SG"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# Frontend Security Group
# -----------------------------
resource "aws_security_group" "frontend_sg" {
  name = "frontend-sg"

  ingress {
    description = "Allow Express from Internet"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# Backend EC2
# -----------------------------
resource "aws_instance" "backend" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  user_data = file("userdata-backend.sh")

  tags = {
    Name = "backend-ec2"
  }
}

# -----------------------------
# Frontend EC2
# -----------------------------
resource "aws_instance" "frontend" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  user_data = templatefile("userdata-frontend.sh", {
    backend_ip = aws_instance.backend.private_ip
  })

  tags = {
    Name = "frontend-ec2"
  }
}