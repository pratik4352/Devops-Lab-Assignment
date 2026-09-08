# DevOps Lab Assignments & Formative Assessment 1 (FA1)

**Author:** Pratik Ghavate ([@pratik4352](https://github.com/pratik4352))  
**Repository:** [Devops-Lab-Assignment](https://github.com/pratik4352/Devops-Lab-Assignment)  
**CI/CD Pipeline Status:** [![CI](https://github.com/pratik4352/Devops-Lab-Assignment/actions/workflows/assignment2-ci.yml/badge.svg)](https://github.com/pratik4352/Devops-Lab-Assignment/actions/workflows/assignment2-ci.yml)  

This repository contains practical implementations, source code, and comprehensive laboratory submission reports for all **5 DevOps Lab Assignments** and the **FA1 Capstone Project**.

---

## 🌟 FA1: Git-Based IaC & Multi-Environment Container Deployment (20 Marks)

> **Assessment Dates:** 10th & 11th September 2026  
> **Directory:** [`📁 FA1/`](./FA1/)  
> **Full Project Report:** [`FA1/FA1_PROJECT_REPORT.md`](./FA1/FA1_PROJECT_REPORT.md)  
> **5-Minute Viva Prep Guide:** [`FA1/VIVA_PREP_GUIDE.md`](./FA1/VIVA_PREP_GUIDE.md)  

### Architecture & Capabilities
* **Two-Container Microservices Architecture:**
  * **Container 1 (Frontend):** Nginx Alpine Single Page Application & Reverse Proxy.
  * **Container 2 (Backend):** Python 3.12 Flask REST API (`/api/status`, `/api/data`).
* **Single-Codebase Terraform IaC:**
  * Declaratively provisions Docker bridge networks, container images, and container instances.
* **Multi-Environment Parameterization (QA / UAT / PROD):**
  * Same Terraform code deployed using `-var-file="environments/qa.tfvars"`, `uat.tfvars`, and `prod.tfvars` without code duplication.

---

## Complete Assignment Syllabus & Status

| Module / Project | Topic | Status | Technology Stack | Deliverables |
| :--- | :--- | :--- | :--- | :--- |
| **FA1 Project** | **Multi-Environment Container Deployment** | ✅ **Completed** | Terraform, Docker, Nginx, Flask | [FA1 Directory](./FA1/) |
| **Assignment 1** | **Git Repository and Branch Management** | ✅ **Completed** | Git, GitHub, Python | [Assignment 1](./Assignment%201/) |
| **Assignment 2** | **Continuous Integration (GitHub Actions)** | ✅ **Completed** | GitHub Actions, Pytest, Flake8 | [Assignment 2](./Assignment%202/) |
| **Assignment 3** | **Infrastructure as Code (Terraform)** | ✅ **Completed** | Terraform (HCL), AWS EC2 | [Assignment 3](./Assignment%203/) |
| **Assignment 4** | **Docker & Docker Compose** | ✅ **Completed** | Docker, Compose, Flask | [Assignment 4](./Assignment%204/) |
| **Assignment 5** | **Cloud & Server Automation (AWS & Ansible)** | ✅ **Completed** | AWS EC2, Ansible, Jinja2, YAML | [Assignment 5](./Assignment%205/) |

---

## Assignment Quick Links

- [📁 FA1: Multi-Environment Container Deployment](./FA1/)
- [📁 Assignment 1: Git Repository & Branch Management](./Assignment%201/)
- [📁 Assignment 2: Continuous Integration Using GitHub Actions](./Assignment%202/)
- [📁 Assignment 3: Infrastructure as Code Using Terraform](./Assignment%203/)
- [📁 Assignment 4: Docker Containerization and Docker Compose](./Assignment%204/)
- [📁 Assignment 5: Cloud Infrastructure and Server Automation Using AWS and Ansible](./Assignment%205/)
