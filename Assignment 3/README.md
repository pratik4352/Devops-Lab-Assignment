# Assignment 3: Infrastructure as Code Using Terraform

This directory contains the Terraform configuration files, architecture definitions, and laboratory documentation for **Assignment 3: Infrastructure as Code Using Terraform**.

---

## Infrastructure Files in this Directory

- [`main.tf`](./main.tf): Declares the AWS provider, security group (`web_sg`), and EC2 virtual machine instance (`app_server`).
- [`variables.tf`](./variables.tf): Input variables defining the AWS region, instance type (`t2.micro`), AMI ID, and resource tags.
- [`outputs.tf`](./outputs.tf): Declares output values (instance ID, public IPv4 address, private IP, and instance ARN).
- [`versions.tf`](./versions.tf): Locks the Terraform version (`>= 1.5.0`) and AWS provider version (`~> 5.0`).
- [`terraform.tfvars.example`](./terraform.tfvars.example): Template for local variable overrides.
- [`ASSIGNMENT_3_REPORT.md`](./ASSIGNMENT_3_REPORT.md): Complete laboratory submission report with concept definitions, workflow diagram, command tables, and execution logs.

---

## How to Execute the Terraform Lifecycle

### 1. Prerequisites
Configure your AWS credentials via environment variables or the AWS CLI:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-east-1"
```

### 2. Initialize the Working Directory
```bash
terraform init
```

### 3. Validate and Format Configuration
```bash
terraform fmt
terraform validate
```

### 4. Review Execution Plan
```bash
terraform plan
```

### 5. Provision the EC2 Instance
```bash
terraform apply -auto-approve
```

### 6. Verify Deployment
- Check instance status in the [AWS EC2 Console](https://console.aws.amazon.com/ec2).
- Access the web server:
  ```bash
  curl http://<INSTANCE_PUBLIC_IP>
  ```

### 7. Clean Teardown (Avoid Cloud Charges)
```bash
terraform destroy -auto-approve
```
