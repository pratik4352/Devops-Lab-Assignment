variable "environment" {
  description = "Target deployment environment (qa, uat, prod)"
  type        = string

  validation {
    condition     = contains(["qa", "uat", "prod"], var.environment)
    error_message = "Environment must be one of: qa, uat, prod."
  }
}

variable "app_name" {
  description = "Base application name"
  type        = string
  default     = "multi-container-app"
}

variable "frontend_host_port" {
  description = "Host port mapped to Container 1 (Frontend Nginx port 80)"
  type        = number
}

variable "backend_host_port" {
  description = "Host port mapped to Container 2 (Backend Flask API port 5000)"
  type        = number
}

variable "backend_log_level" {
  description = "Application log verbosity level"
  type        = string
  default     = "INFO"
}

variable "restart_policy" {
  description = "Container restart policy"
  type        = string
  default     = "unless-stopped"
}
