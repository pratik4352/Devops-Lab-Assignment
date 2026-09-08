# Bridge network isolated per environment
resource "docker_network" "app_network" {
  name = "${var.app_name}-${var.environment}-net"
}

# Container 2: Backend API Image
resource "docker_image" "backend" {
  name = "${var.app_name}-backend:${var.environment}"
  build {
    context = "${path.module}/../docker/backend"
  }
}

# Container 2: Backend API Service
resource "docker_container" "backend" {
  name  = "${var.app_name}-backend-${var.environment}"
  image = docker_image.backend.image_id

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["backend"]
  }

  ports {
    internal = 5000
    external = var.backend_host_port
  }

  env = [
    "ENVIRONMENT=${var.environment}",
    "APP_VERSION=1.0.0",
    "LOG_LEVEL=${var.backend_log_level}",
    "PORT=5000"
  ]

  restart = var.restart_policy
}

# Container 1: Frontend Web Application Image
resource "docker_image" "frontend" {
  name = "${var.app_name}-frontend:${var.environment}"
  build {
    context = "${path.module}/../docker/frontend"
  }
}

# Container 1: Frontend Web Service
resource "docker_container" "frontend" {
  name  = "${var.app_name}-frontend-${var.environment}"
  image = docker_image.frontend.image_id

  networks_advanced {
    name    = docker_network.app_network.name
    aliases = ["frontend"]
  }

  ports {
    internal = 80
    external = var.frontend_host_port
  }

  restart = var.restart_policy

  depends_on = [docker_container.backend]
}
