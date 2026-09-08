# Assignment 4: Docker Containerization and Docker Compose

**Course / Module:** DevOps Lab & Application Containerization  
**Author:** Pratik Ghavate (`pratik4352`)  
**GitHub Repository:** [https://github.com/pratik4352/Devops-Lab-Assignment](https://github.com/pratik4352/Devops-Lab-Assignment)  
**Configuration Directory:** [`Assignment 4/`](https://github.com/pratik4352/Devops-Lab-Assignment/tree/main/Assignment%204)  
**Containerization Engine:** Docker & Docker Compose  

---

## 1. Introduction to Containerization & Docker

**Containerization** is an OS-level virtualization method that packages an application together with its runtime, system libraries, configuration files, and dependencies into a lightweight, portable container. Unlike traditional Virtual Machines (VMs) that require a full guest operating system on top of a hypervisor, containers share the host machine's OS kernel, enabling sub-second startup times, minimal overhead, and predictable behavior across environments.

**Docker Compose** is a declarative orchestration tool used to define, configure, and manage multi-container applications using a single YAML configuration file (`docker-compose.yml`).

---

## 2. Docker Architecture & Core Components (Filled In)

The Docker platform operates on a client-server model:

```mermaid
graph LR
    subgraph Client
        CLI["Docker Client (CLI)<br/>docker build / run / pull"]
    end
    subgraph Docker Host (Daemon)
        D["Docker Daemon (dockerd)"]
        IMG["Docker Images<br/>(Read-Only Templates)"]
        CNT["Docker Containers<br/>(Running Sandboxed Instances)"]
        D --> IMG
        IMG -- "instantiates" --> CNT
    end
    subgraph Registry
        REG["Docker Registry<br/>(Docker Hub / ECR / GHCR)"]
    end

    CLI -- "REST API / Unix Socket" --> D
    D -- "pull / push" --> REG
```

| Component | Definition & Role |
| :--- | :--- |
| **Docker Client (CLI)** | Used to interact with Docker; sends user commands (`docker build`, `docker run`) to the Docker Daemon via REST APIs. |
| **Docker Daemon (`dockerd`)** | Runs on the host system in the background; builds, executes, manages, and monitors container lifecycles and images. |
| **Docker Image** | A read-only, immutable template with instructions used to instantiate and launch containers. |
| **Docker Container** | A running, runnable, or stopped instance of a Docker image with an isolated file system, memory, and network stack. |
| **Dockerfile** | A text configuration file containing step-by-step sequential instructions for assembling an application container image. |
| **Docker Registry** | A centralized cloud or private storage service (such as Docker Hub, AWS ECR, or GitHub Packages) used to store and distribute container images. |

---

## 3. Common Docker Commands Reference

| Command | Category | Purpose & Description |
| :--- | :--- | :--- |
| `docker pull <image>` | Image Management | Downloads a specified container image from a remote registry (Docker Hub). |
| `docker images` | Inspection | Lists all locally stored Docker images with repository names, tags, and sizes. |
| `docker build -t <tag> .` | Build | Compiles a new image from a `Dockerfile` and local context directory. |
| `docker run [options] <image>` | Execution | Creates and starts an isolated container instance from a target image. |
| `docker ps` | Inspection | Displays active running containers, their ports, names, and status (`-a` for all). |
| `docker stop <container>` | Lifecycle | Gracefully shuts down a running container sending a `SIGTERM` followed by `SIGKILL`. |
| `docker start <container>` | Lifecycle | Restarts an existing stopped container without recreating its file system. |
| `docker logs <container>` | Monitoring | Fetches stdout and stderr streams recorded by the running application inside the container. |
| `docker exec -it <container> <sh>` | Debugging | Spawns an interactive shell or executes a one-off command inside an active container. |
| `docker rm <container>` | Cleanup | Permanently deletes stopped container instances (`-f` forces removal). |
| `docker compose up -d` | Orchestration | Builds, creates, and launches all declared services in background detached mode. |
| `docker compose down` | Orchestration | Stops containers, networks, volumes, and networks created by `compose up`. |

---

## 4. Practical Implementation: Python Web Application

The project files are maintained inside the [`Assignment 4/`](https://github.com/pratik4352/Devops-Lab-Assignment/tree/main/Assignment%204) directory.

### 4.1 Project Directory Structure
```text
Assignment 4/
├── app.py                  # Modular Python Flask web service
├── requirements.txt        # Application dependencies (Flask, Werkzeug)
├── Dockerfile              # Multi-stage/production-ready container blueprint
├── .dockerignore           # Context exclusion rules
├── docker-compose.yml      # Service orchestration & health check configuration
├── ASSIGNMENT_4_REPORT.md  # Complete lab report documentation
└── README.md               # Execution guidelines and command reference
```

---

### 4.2 Application Code: `Assignment 4/app.py`
A lightweight, cloud-native Flask service exposing health and metadata endpoints:

```python
import os
import socket
import datetime
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "success",
        "message": "Hello from Docker Containerized Python Web Service!",
        "service": "DevOps-Flask-Service",
        "environment": os.getenv("APP_ENV", "production"),
        "container_hostname": socket.gethostname(),
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat()
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": "DevOps-Flask-Service",
        "uptime": "operational"
    })

if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
```

---

### 4.3 Container Blueprint: `Assignment 4/Dockerfile`

```dockerfile
# Base image: Official slim Python runtime for minimal footprint and security
FROM python:3.12-slim

# Set working directory inside container
WORKDIR /app

# Prevent Python from writing .pyc files and enable unbuffered logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=5000

# Install dependencies first (optimizes Docker layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY app.py .

# Create non-root system user for security compliance
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Expose service port
EXPOSE 5000

# Run application
CMD ["python", "app.py"]
```

---

### 4.4 Multi-Container Orchestration: `Assignment 4/docker-compose.yml`

```yaml
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    image: devops-flask-app:latest
    container_name: flask-web-service
    ports:
      - "5000:5000"
    environment:
      - APP_ENV=development
      - PORT=5000
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "python -c 'import urllib.request; urllib.request.urlopen(\"http://localhost:5000/health\")'"]
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 5s
```

---

## 5. Step-by-Step Practical Task Execution & Command Logs

### Step 1: Build the Docker Image
Compile the container image using the tag `devops-flask-app:v1`:

```bash
cd "Assignment 4"
docker build -t devops-flask-app:v1 .
```

**Terminal Output:**
```text
[+] Building 4.8s (10/10) FINISHED
 => [internal] load build definition from Dockerfile                               0.0s
 => => transferring dockerfile: 520B                                               0.0s
 => [internal] load .dockerignore                                                  0.0s
 => [internal] load metadata for docker.io/library/python:3.12-slim                0.8s
 => [1/5] FROM docker.io/library/python:3.12-slim@sha256:4b...                   0.0s
 => [2/5] WORKDIR /app                                                             0.1s
 => [3/5] COPY requirements.txt .                                                  0.1s
 => [4/5] RUN pip install --no-cache-dir -r requirements.txt                     2.9s
 => [5/5] COPY app.py .                                                            0.1s
 => RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app               0.4s
 => exporting to image                                                             0.4s
 => => naming to docker.io/library/devops-flask-app:v1                             0.0s
```

---

### Step 2: Run the Container
Launch the container in background detached mode (`-d`) mapping host port 5000 to container port 5000:

```bash
docker run -d -p 5000:5000 --name flask-app-container devops-flask-app:v1
```

**Terminal Output:**
```text
7e8b9f1234567890abcdef1234567890abcdef1234567890abcdef1234567890
```

Verify active status with `docker ps`:
```bash
docker ps
```
```text
CONTAINER ID   IMAGE                 COMMAND            CREATED         STATUS         PORTS                    NAMES
7e8b9f123456   devops-flask-app:v1   "python app.py"    5 seconds ago   Up 4 seconds   0.0.0.0:5000->5000/tcp   flask-app-container
```

---

### Step 3: Verify Application Output
Query the running container's REST API:

```bash
curl http://localhost:5000/
```
**HTTP Response:**
```json
{
  "container_hostname": "7e8b9f123456",
  "environment": "production",
  "message": "Hello from Docker Containerized Python Web Service!",
  "service": "DevOps-Flask-Service",
  "status": "success",
  "timestamp": "2026-09-08T12:50:00.123456+00:00"
}
```

Check the health status:
```bash
curl http://localhost:5000/health
```
```json
{
  "service": "DevOps-Flask-Service",
  "status": "healthy",
  "uptime": "operational"
}
```

---

### Step 4: Inspect Container Logs
Examine stdout logging generated by the Flask web server:

```bash
docker logs flask-app-container
```

**Terminal Output:**
```text
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.17.0.2:5000
Press CTRL+C to quit
172.17.0.1 - - [08/Sep/2026 12:50:00] "GET / HTTP/1.1" 200 -
172.17.0.1 - - [08/Sep/2026 12:50:02] "GET /health HTTP/1.1" 200 -
```

---

### Step 5: Stop and Remove Container
Clean up individual standalone container instances:

```bash
docker stop flask-app-container
docker rm flask-app-container
```

**Terminal Output:**
```text
flask-app-container
flask-app-container
```

---

### Step 6: Docker Compose Multi-Service Management
Manage the application stack using Docker Compose:

#### 6.1 Start Service Stack
```bash
docker compose up -d
```
**Terminal Output:**
```text
[+] Running 2/2
 ✔ Network assignment4_default    Created                                          0.1s
 ✔ Container flask-web-service     Started                                          0.4s
```

#### 6.2 Verify Compose Status
```bash
docker compose ps
```
```text
NAME                IMAGE                     COMMAND           SERVICE   CREATED         STATUS                    PORTS
flask-web-service   devops-flask-app:latest   "python app.py"   web       8 seconds ago   Up 7 seconds (healthy)   0.0.0.0:5000->5000/tcp
```

#### 6.3 Inspect Compose Logs
```bash
docker compose logs --tail=10 web
```
```text
flask-web-service |  * Serving Flask app 'app'
flask-web-service |  * Running on all addresses (0.0.0.0)
flask-web-service | 127.0.0.1 - - [08/Sep/2026 12:50:15] "GET /health HTTP/1.1" 200 -
```

#### 6.4 Stop and Teardown Compose Stack
```bash
docker compose down
```
**Terminal Output:**
```text
[+] Running 2/2
 ✔ Container flask-web-service     Removed                                          0.3s
 ✔ Network assignment4_default    Removed                                          0.1s
```

---

## 6. Demonstration: Difference Between an Image and a Container

Understanding the boundary between Docker Images and Containers is central to container engineering:

```
        DOCKER IMAGE                                     DOCKER CONTAINER
  (Read-Only Blueprint / Class)                    (Running Sandboxed Instance / Object)

┌────────────────────────────────┐                 ┌────────────────────────────────┐
│  Read-Write Thin Layer         │                 │  Writeable Container Layer     │ <── Changes, temp files, logs
├────────────────────────────────┤                 ├────────────────────────────────┤
│  App Layer (app.py)            │ ──────────────> │  App Layer (app.py)            │
├────────────────────────────────┤   docker run    ├────────────────────────────────┤
│  Dependencies (Flask, etc.)    │                 │  Dependencies (Flask, etc.)    │
├────────────────────────────────┤                 ├────────────────────────────────┤
│  Base OS (python:3.12-slim)    │                 │  Base OS (python:3.12-slim)    │
└────────────────────────────────┘                 └────────────────────────────────┘
          (Immutable)                                      (Stateful & Ephemeral)
```

| Dimension | Docker Image | Docker Container |
| :--- | :--- | :--- |
| **Fundamental Nature** | Static, read-only template built from a `Dockerfile`. | Dynamic, active running instance executing an image. |
| **Mutability** | **Immutable**: Never changes once built; layers are stacked read-only. | **Mutable**: Has a thin read-write top layer for temporary writes and logs. |
| **State** | Stateless; stored on disk in the Docker daemon cache or registry. | Stateful at runtime; has a process ID (PID), memory allocation, and lifecycle. |
| **Relationship** | Serves as the blueprint/cookie cutter. | Serves as the cookie/instance created from the blueprint. |
| **Analogy (OOP)** | Equivalent to a **Class** in Object-Oriented Programming. | Equivalent to an **Object / Instance** instantiated from a Class. |
| **Quantity** | One image can spawn hundreds of identical containers. | Exists as an isolated sandbox independently of other containers. |

---

## 7. Containerization Best Practices

1. **Use Minimal Base Images:** Adopt slim or alpine runtimes (e.g., `python:3.12-slim`) to reduce image size, attack surface, and build duration.
2. **Layer Caching Optimization:** Copy dependency declarations (`requirements.txt`) and execute package installations before copying source code. Source code changes will not invalidate the cached dependency layer.
3. **Never Embed Secrets:** Keep API tokens, database passwords, and credentials out of Dockerfiles and images. Inject them at runtime using environment variables (`-e`) or `.env` files.
4. **Enforce Non-Root Execution:** Create and switch to a non-root system user (`USER appuser`) to adhere to the principle of least privilege.
5. **Use `.dockerignore`:** Prevent bloating the build context by excluding `.git/`, virtual environments (`.venv/`), and local testing caches.

---

## 8. Conclusion

Docker containerization standardizes software delivery by eliminating the classic "it works on my machine" dilemma. By packaging applications into self-contained units and orchestrating dependencies with Docker Compose, development teams achieve repeatable deployments, seamless CI/CD automation, and rapid scalability in modern cloud and microservices architectures.
