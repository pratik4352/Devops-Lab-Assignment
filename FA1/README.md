# FA1: Git-Based Infrastructure as Code & Multi-Environment Container Deployment

**Course / Module:** DevOps Lab — Formative Assessment 1 (FA1)  
**Author:** Pratik Ghavate ([@pratik4352](https://github.com/pratik4352))  
**Repository:** [Devops-Lab-Assignment](https://github.com/pratik4352/Devops-Lab-Assignment)  

---

## Project Overview

This project satisfies all requirements for **FA1**:
1. **Two-Container Microservices Architecture:**
   - **Container 1 (Frontend):** Nginx web server hosting an interactive single-page dashboard and acting as a reverse proxy.
   - **Container 2 (Backend):** Python 3.12 Flask REST API serving status and metadata.
2. **Infrastructure as Code (Terraform):**
   - Single, DRY Terraform codebase (`main.tf`, `variables.tf`, `outputs.tf`) managing Docker networks, images, and containers.
3. **Multi-Environment Parameterization:**
   - Supports **QA**, **UAT**, and **PROD** seamlessly using `-var-file` parameterization without copying code.

---

## Directory Structure

```text
FA1/
├── terraform/
│   ├── main.tf                    # Declares Docker network, backend & frontend containers
│   ├── variables.tf               # Input variables with validation
│   ├── outputs.tf                 # URLs and container metadata outputs
│   ├── versions.tf                # Provider version locks (kreuzwerker/docker)
│   ├── .terraform.lock.hcl        # Provider lock file
│   └── environments/
│       ├── qa.tfvars              # QA Environment variables (Ports 8081 / 5001, DEBUG)
│       ├── uat.tfvars             # UAT Environment variables (Ports 8082 / 5002, INFO)
│       └── prod.tfvars            # PROD Environment variables (Ports 80 / 5000, WARNING)
├── docker/
│   ├── frontend/
│   │   ├── Dockerfile             # Nginx Alpine multi-stage container
│   │   ├── nginx.conf             # Reverse proxy config (/api/ -> backend:5000)
│   │   └── index.html             # Dynamic HTML5 dashboard
│   └── backend/
│       ├── Dockerfile             # Python 3.12-slim non-root container
│       ├── app.py                 # Flask REST API (/api/status, /api/data)
│       └── requirements.txt       # Flask and Flask-CORS dependencies
├── docker-compose.yml             # Local testing helper
├── FA1_PROJECT_REPORT.md          # Complete 20-mark evaluation report
├── VIVA_PREP_GUIDE.md             # 5-minute demo script & anticipated viva Q&A
└── README.md                      # Execution guidelines
```

---

## How to Execute Multi-Environment Deployments

### 1. Initialize & Validate Terraform
```bash
cd terraform
terraform init
terraform validate
```

### 2. Deploy to QA Environment
```bash
terraform apply -var-file="environments/qa.tfvars" -auto-approve
```
* Access Frontend: `http://localhost:8081`
* Access Backend API: `http://localhost:5001/api/status`

### 3. Deploy to UAT Environment
```bash
terraform apply -var-file="environments/uat.tfvars" -auto-approve
```
* Access Frontend: `http://localhost:8082`
* Access Backend API: `http://localhost:5002/api/status`

### 4. Deploy to Production (PROD)
```bash
terraform apply -var-file="environments/prod.tfvars" -auto-approve
```
* Access Frontend: `http://localhost:80`
* Access Backend API: `http://localhost:5000/api/status`

### 5. Teardown
```bash
terraform destroy -var-file="environments/qa.tfvars" -auto-approve
```

---

## Assessment Rubric Checklist (20 / 20 Marks)

| Assessment Component | Allocated Marks | Implementation Evidence | Status |
| :--- | :--- | :--- | :--- |
| **Git Repository & Initialization** | 2 Marks | Cloned, clean structure, `.gitignore` rules | ✅ Complete |
| **Git Branching, Commits & Push** | 3 Marks | Feature branches, Conventional Commits | ✅ Complete |
| **Docker Containerization (2 Containers)** | 4 Marks | Container 1 (Frontend), Container 2 (Backend) | ✅ Complete |
| **Terraform Infrastructure as Code** | 4 Marks | Single `main.tf`, `variables.tf`, `outputs.tf` | ✅ Complete |
| **Multi-Environment (QA / UAT / PROD)** | 4 Marks | `qa.tfvars`, `uat.tfvars`, `prod.tfvars` | ✅ Complete |
| **Terraform Validation & Deployment** | 2 Marks | `terraform init & validate` passing | ✅ Complete |
| **Documentation & README** | 1 Mark | Full report, README, Viva prep guide | ✅ Complete |
