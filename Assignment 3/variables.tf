variable "aws_region" {
  description = "The AWS region where resources will be provisioned"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The EC2 instance type (Free Tier eligible: t2.micro or t3.micro)"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The Amazon Machine Image (AMI) ID for the virtual machine"
  type        = string
  default     = "ami-0c7217cdde317cfec" # Amazon Linux 2023 AMI in us-east-1
}

variable "instance_name" {
  description = "Name tag for the EC2 virtual machine instance"
  type        = string
  default     = "DevOps-Lab-EC2-Instance"
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "DevOps-Lab"
}
