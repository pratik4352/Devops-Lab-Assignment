# DevOps Lab Assignments

**Author:** Pratik Ghavate ([@pratik4352](https://github.com/pratik4352))  
**Repository:** [Devops-Lab-Assignment](https://github.com/pratik4352/Devops-Lab-Assignment)  
**CI/CD Pipeline Status:** [![CI](https://github.com/pratik4352/Devops-Lab-Assignment/actions/workflows/assignment2-ci.yml/badge.svg)](https://github.com/pratik4352/Devops-Lab-Assignment/actions/workflows/assignment2-ci.yml)

This repository contains comprehensive practical implementations, production-ready code, and detailed laboratory submission reports for all 5 DevOps course assignments.

---

## Complete Assignment Syllabus & Status

| Directory | Title | Status | Technology Stack | Deliverables |
| :--- | :--- | :--- | :--- | :--- |
| [📁 Assignment 1](./Assignment%201/) | **Git Repository and Branch Management** | ✅ Completed | Git, GitHub, Python | Branching, 3-Way Merge, Reset vs. Revert, Report |
| [📁 Assignment 2](./Assignment%202/) | **Continuous Integration Using GitHub Actions** | ✅ Completed | GitHub Actions, Python, Pytest, Flake8 | Automated CI Workflow, Linting, Testing, Report |
| [📁 Assignment 3](./Assignment%203/) | **Infrastructure as Code Using Terraform** | ✅ Completed | Terraform (HCL), AWS EC2 | Declarative HCL, AWS EC2, SGs, Variables, Report |
| [📁 Assignment 4](./Assignment%204/) | **Docker Containerization and Docker Compose** | ✅ Completed | Docker, Dockerfile, Compose, Flask | Multi-layer Container, Compose Stack, Report |
| [📁 Assignment 5](./Assignment%205/) | **Cloud Infrastructure & Server Automation (AWS & Ansible)** | ✅ Completed | AWS EC2, Ansible, Jinja2, YAML | Agentless Automation, Playbooks, Jinja2, Report |

---

## Assignment Summaries & Quick Links

### 1. [Assignment 1: Git Repository and Branch Management](./Assignment%201/)
* **Core Topics:** Distributed VCS, Git 3-Tree Architecture (Working Directory, Staging Area, Local Repository, Remote), Feature Branching, 3-Way Merging, `git reset` vs. `git revert`.
* **Deliverables:** [`calculator.py`](./Assignment%201/calculator.py), [`ASSIGNMENT_1_REPORT.md`](./Assignment%201/ASSIGNMENT_1_REPORT.md).

### 2. [Assignment 2: Continuous Integration Using GitHub Actions](./Assignment%202/)
* **Core Topics:** Continuous Integration, GitHub Actions Architecture (Workflows, Events, Jobs, Steps, Runners, Actions), Automated Code Linting (`flake8`), Automated Unit Testing (`pytest`), Intentional Failure vs. Correction lifecycle.
* **Deliverables:** [`app.py`](./Assignment%202/app.py), [`test_app.py`](./Assignment%202/test_app.py), [`.github/workflows/assignment2-ci.yml`](./.github/workflows/assignment2-ci.yml), [`ASSIGNMENT_2_REPORT.md`](./Assignment%202/ASSIGNMENT_2_REPORT.md).

### 3. [Assignment 3: Infrastructure as Code Using Terraform](./Assignment%203/)
* **Core Topics:** Infrastructure as Code (IaC), Declarative HCL, Providers, Resources, Variables, State, Execution Lifecycle (`init`, `validate`, `fmt`, `plan`, `apply`, `destroy`), AWS EC2 Virtual Machine Provisioning.
* **Deliverables:** [`main.tf`](./Assignment%203/main.tf), [`variables.tf`](./Assignment%203/variables.tf), [`outputs.tf`](./Assignment%203/outputs.tf), [`versions.tf`](./Assignment%203/versions.tf), [`ASSIGNMENT_3_REPORT.md`](./Assignment%203/ASSIGNMENT_3_REPORT.md).

### 4. [Assignment 4: Docker Containerization and Docker Compose](./Assignment%204/)
* **Core Topics:** OS-Level Virtualization, Docker Architecture (Client, Daemon, Image, Container, Registry), Multi-layer Dockerfile Caching, Non-Root Security, Docker Compose Multi-Service Management, Image vs. Container Comparison.
* **Deliverables:** [`app.py`](./Assignment%204/app.py), [`Dockerfile`](./Assignment%204/Dockerfile), [`docker-compose.yml`](./Assignment%204/docker-compose.yml), [`ASSIGNMENT_4_REPORT.md`](./Assignment%204/ASSIGNMENT_4_REPORT.md).

### 5. [Assignment 5: Cloud Infrastructure and Server Automation Using AWS and Ansible](./Assignment%205/)
* **Core Topics:** AWS Cloud Services (EC2, S3, RDS, Aurora, ELB, ECS), Ansible Agentless Architecture, Control Nodes, Managed Nodes, Host Inventories, Declarative YAML Playbooks, Idempotency, Dynamic Jinja2 Templating.
* **Deliverables:** [`playbook.yml`](./Assignment%205/playbook.yml), [`update_webpage.yml`](./Assignment%205/update_webpage.yml), [`ansible.cfg`](./Assignment%205/ansible.cfg), [`inventory.ini.example`](./Assignment%205/inventory.ini.example), [`templates/index.html.j2`](./Assignment%205/templates/index.html.j2), [`ASSIGNMENT_5_REPORT.md`](./Assignment%205/ASSIGNMENT_5_REPORT.md).
