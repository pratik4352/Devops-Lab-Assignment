# Execution Screenshots Guide — FA1 & DevOps Lab

This directory is designated for storing execution screenshots required for the **FA1 (Formative Assessment 1)** evaluation on **10th & 11th September 2026**.

---

## Required Screenshots Checklist (Mapped to 20-Mark Rubric)

| # | Screenshot Name | Assessment Rubric | What to Capture | Command / Screen |
| :-: | :--- | :--- | :--- | :--- |
| **1** | `01_git_history_graph.png` | **Git Branching, Commits & Push (3 Marks)** | Terminal showing Git commit tree, branch merge, and Conventional Commits. | `git log --graph --oneline --decorate --all -n 12` |
| **2** | `02_github_repo_overview.png` | **Git Repository & Initialization (2 Marks)** | Web browser showing the repository homepage on GitHub with all folders. | Browser: `https://github.com/pratik4352/Devops-Lab-Assignment` |
| **3** | `03_github_actions_ci.png` | **Continuous Integration (Assignment 2)** | GitHub Actions tab showing workflow history (failure & success runs). | Browser: `https://github.com/pratik4352/Devops-Lab-Assignment/actions` |
| **4** | `04_docker_2_containers.png` | **Docker Containerization — 2 Containers (4 Marks)** | Dockerfiles, images list, or running containers for Frontend & Backend. | `docker images` or `docker ps` |
| **5** | `05_terraform_validation.png` | **Terraform Validation & Deployment (2 Marks)** | Terminal showing `terraform init` and `terraform validate` passing. | `cd FA1/terraform && terraform validate` |
| **6** | `06_terraform_multienv_plan.png` | **Multi-Environment Config — QA/UAT/PROD (4 Marks)** | Terminal output of `terraform plan` using `-var-file="environments/qa.tfvars"`. | `terraform plan -var-file="environments/qa.tfvars"` |
| **7** | `07_application_dashboard.png` | **Documentation & Working Output (1 Mark)** | Browser showing the live multi-environment web dashboard. | Browser: `http://localhost:8081` |

---

## How to Take Screenshots on Windows

1. Press **`Win + Shift + S`** to open the Windows Snipping Tool.
2. Select **Window Snip** or drag across the terminal/browser window.
3. Save the image into this `screenshots/` directory with the numbered filenames above.
4. Add, commit, and push to GitHub:
   ```bash
   git add screenshots/
   git commit -m "docs: add FA1 execution screenshots for evaluation"
   git push origin main
   ```
