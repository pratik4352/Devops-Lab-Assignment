output "target_environment" {
  description = "Active deployment environment"
  value       = var.environment
}

output "frontend_url" {
  description = "URL to access Container 1 (Frontend Web Application)"
  value       = "http://localhost:${var.frontend_host_port}"
}

output "backend_api_url" {
  description = "URL to access Container 2 (Backend REST API)"
  value       = "http://localhost:${var.backend_host_port}/api/status"
}

output "frontend_container_name" {
  description = "Name of the provisioned Frontend container"
  value       = docker_container.frontend.name
}

output "backend_container_name" {
  description = "Name of the provisioned Backend container"
  value       = docker_container.backend.name
}

output "network_name" {
  description = "Docker virtual bridge network connecting both containers"
  value       = docker_network.app_network.name
}
