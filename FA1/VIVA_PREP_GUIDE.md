# FA1 — 5-Minute Demo & Viva Preparation Guide

**Assessment:** Formative Assessment 1 (FA1)  
**Topic:** Git-Based Infrastructure as Code and Multi-Environment Container Deployment  
**Candidate:** Pratik Ghavate ([@pratik4352](https://github.com/pratik4352))  
**Assessment Dates:** 10th & 11th Sep 2026  

---

## 1. Five-Minute Live Demo Pitch Script

### Minute 1: Introduction & Architecture (30-60 seconds)
> *"Good morning, Sir/Madam. My name is Pratik Ghavate. Today I am presenting my FA1 project: Git-Based Infrastructure as Code and Multi-Environment Container Deployment.*  
> *The project consists of two containerized microservices:*  
> *1. Container 1 is an Nginx frontend serving a single-page application and acting as a reverse proxy.*  
> *2. Container 2 is a Python Flask backend REST API that provides environment metadata and status.*  
> *Instead of managing containers manually, both containers and their isolated bridge networks are declared and provisioned using HashiCorp Terraform."*

### Minute 2: Single-Codebase Multi-Environment Philosophy (60-120 seconds)
> *"The core requirement was to support QA, UAT, and PROD without duplicating the infrastructure code. As shown in my `terraform/` directory, I maintain a single `main.tf`, `variables.tf`, and `outputs.tf`.*  
> *All environment-specific differences—such as port bindings, logging verbosity, and container restart policies—are passed dynamically using `-var-file` parameter files:*  
> `- QA deploys on port 8081 (frontend) & 5001 (backend) with DEBUG logs.`  
> `- UAT deploys on port 8082 (frontend) & 5002 (backend) with INFO logs.`  
> `- PROD deploys on port 80 (frontend) & 5000 (backend) with WARNING logs and an 'always' restart policy."*

### Minute 3: Terraform Execution Demonstration (120-180 seconds)
> *"To deploy the QA environment, I run:*  
> `cd terraform`  
> `terraform init`  
> `terraform validate` (Success: configuration is valid)  
> `terraform plan -var-file="environments/qa.tfvars"`  
> *Terraform reads `qa.tfvars`, calculates the resource graph, and prepares to create 2 images, 2 containers, and 1 isolated virtual bridge network.*  
> *Executing `terraform apply -var-file="environments/qa.tfvars" -auto-approve` immediately provisions the entire QA environment."*

### Minute 4: Service Verification (180-240 seconds)
> *"Once applied, Terraform outputs the frontend and backend URLs:*  
> `curl http://localhost:8081` -> Serves the Nginx frontend.  
> `curl http://localhost:5001/api/status` -> Returns JSON containing `"status": "healthy", "environment": "qa"`.*  
> *The frontend automatically fetches data from the backend container through the internal Docker network."*

### Minute 5: Teardown & Conclusion (240-300 seconds)
> *"To prevent resource leakage, I execute:*  
> `terraform destroy -var-file="environments/qa.tfvars" -auto-approve`  
> *Terraform gracefully stops and destroys the containers, images, and bridge network in reverse dependency order.*  
> *All 5 preliminary assignments and this FA1 capstone are tracked with conventional commits and branches in my GitHub repository."*

---

## 2. Anticipated Viva Questions & Model Answers

### Q1: Why should we use Terraform to manage Docker containers instead of docker-compose or manual docker run commands?
**Answer:**  
Terraform provides a unified, declarative Infrastructure-as-Code (IaC) model that manages Docker alongside cloud infrastructure (AWS, Azure, GCP), networking, and DNS in a single workflow. It maintains state (`terraform.tfstate`), detects configuration drift, enforces resource dependencies (`depends_on`), and supports multi-environment parameterization via `.tfvars`.

### Q2: How does your configuration achieve multi-environment deployment without duplicating code?
**Answer:**  
By separating **declarative logic** from **environment data**. The core resource definitions in `main.tf` reference input variables (`var.environment`, `var.frontend_host_port`, `var.backend_log_level`). We inject environment-specific values at runtime using:
```bash
terraform apply -var-file="environments/qa.tfvars"
terraform apply -var-file="environments/uat.tfvars"
terraform apply -var-file="environments/prod.tfvars"
```
This ensures DRY (Don't Repeat Yourself) compliance and prevents configuration drift across stages.

### Q3: What is the purpose of the Docker network defined in `main.tf`?
**Answer:**  
The `docker_network` resource creates an isolated virtual bridge network. By connecting both containers to this network and assigning network aliases (`backend`, `frontend`), the Nginx reverse proxy can resolve the backend service via internal DNS (`http://backend:5000/api/`) without exposing internal container ports directly to the public host network.

### Q4: Explain the difference between `terraform.tfstate` and `.tfvars` files.
**Answer:**  
- **`.tfvars`:** Human-authored input files that specify values for variables defined in `variables.tf`.
- **`terraform.tfstate`:** A Terraform-generated JSON file that records the real-world IDs, attributes, and status of provisioned resources. It acts as the "source of truth" to determine what needs to be added, changed, or destroyed.

### Q5: How is security ensured in your Dockerfiles?
**Answer:**  
1. Minimal base images (`python:3.12-slim`, `nginx:alpine`) to minimize attack surfaces.
2. Layer caching optimization (copying `requirements.txt` before application code).
3. Running containers as a non-privileged user (`USER appuser`, UID 1000) rather than root.
4. Using `.dockerignore` to exclude `.git`, caches, and secrets.
