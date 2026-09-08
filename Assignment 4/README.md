# Assignment 4: Docker Containerization and Docker Compose

This directory contains the application code, containerization manifests, and laboratory documentation for **Assignment 4: Docker Containerization and Docker Compose**.

---

## Application & Container Manifests

- [`app.py`](./app.py): Modular Python Flask web application exposing root and `/health` endpoints.
- [`requirements.txt`](./requirements.txt): Python dependencies (`Flask`, `Werkzeug`).
- [`Dockerfile`](./Dockerfile): Production-ready container image definition with layer caching and non-root user execution.
- [`.dockerignore`](./.dockerignore): Build context exclusion rules.
- [`docker-compose.yml`](./docker-compose.yml): Multi-service definition with automated health checks, port bindings, and restart policies.
- [`ASSIGNMENT_4_REPORT.md`](./ASSIGNMENT_4_REPORT.md): Complete laboratory submission report with architecture diagrams, command tables, lifecycle logs, and the Image vs. Container comparison.

---

## How to Run the Application

### Option A: Standalone Docker CLI
1. **Build the container image:**
   ```bash
   docker build -t devops-flask-app:v1 .
   ```
2. **Run the container in detached mode:**
   ```bash
   docker run -d -p 5000:5000 --name flask-app-container devops-flask-app:v1
   ```
3. **Verify the running application:**
   ```bash
   curl http://localhost:5000/
   curl http://localhost:5000/health
   ```
4. **Inspect container logs:**
   ```bash
   docker logs -f flask-app-container
   ```
5. **Stop and clean up:**
   ```bash
   docker stop flask-app-container
   docker rm flask-app-container
   ```

---

### Option B: Docker Compose Orchestration
1. **Launch the stack in detached mode:**
   ```bash
   docker compose up -d
   ```
2. **Check service status and health:**
   ```bash
   docker compose ps
   ```
3. **View service logs:**
   ```bash
   docker compose logs -f web
   ```
4. **Tear down the stack:**
   ```bash
   docker compose down
   ```
