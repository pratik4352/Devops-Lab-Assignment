# Assignment 2: Continuous Integration Using GitHub Actions

This directory contains the application code, unit test suite, and comprehensive documentation for **Assignment 2: Continuous Integration Using GitHub Actions**.

---

## Files in this Directory

- [`app.py`](./app.py): Application module providing mathematical utilities and string operations.
- [`test_app.py`](./test_app.py): Automated unit test suite compatible with `unittest` and `pytest`.
- [`requirements.txt`](./requirements.txt): Python dependencies (`pytest`, `flake8`).
- [`ASSIGNMENT_2_REPORT.md`](./ASSIGNMENT_2_REPORT.md): Complete laboratory submission report with GitHub Actions components, workflow breakdown, and failure/success verification logs.

---

## Continuous Integration Workflow
- **Workflow Path:** [`.github/workflows/assignment2-ci.yml`](../.github/workflows/assignment2-ci.yml)
- **Trigger Events:** `push` and `pull_request` on branch `main`, plus manual `workflow_dispatch`.
- **Runner Environment:** `ubuntu-latest` with Python 3.12.
- **Workflow Pipeline:**
  1. Checkout code (`actions/checkout@v4`)
  2. Setup Python environment (`actions/setup-python@v5`)
  3. Install dependencies from `requirements.txt`
  4. Code formatting & linting with `flake8`
  5. Automated test execution with `pytest`
  6. Job status and metadata reporting

---

## Live GitHub Actions Verification Runs

| Status | Run ID | Commit | Description | GitHub Action Link |
| :--- | :--- | :--- | :--- | :--- |
| ❌ **Failure** | `34226232874` | `bcf9ea3` | Intentional test failure test | [View Run #1](https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226232874) |
| ✅ **Success** | `34226382980` | `2638df6` | Corrected arithmetic test suite | [View Run #2](https://github.com/pratik4352/Devops-Lab-Assignment/actions/runs/34226382980) |
