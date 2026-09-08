# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "DevOps-Lab-Assignment"
      ManagedBy = "Terraform"
    }
  }
}

# Security Group for EC2 Instance
resource "aws_security_group" "web_sg" {
  name        = "devops-lab-sg"
  description = "Allow inbound SSH and HTTP traffic for DevOps lab instance"

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "devops-lab-security-group"
    Environment = var.environment
  }
}

# AWS EC2 Virtual Machine Instance
resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello from Terraform provisioned EC2 instance!" > index.html
              python3 -m http.server 80 &
              EOF

  tags = {
    Name        = var.instance_name
    Environment = var.environment
    Course      = "DevOps"
  }
}
