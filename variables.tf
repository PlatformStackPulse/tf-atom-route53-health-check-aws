variable "fqdn" {
  description = "FQDN to health check"
  type        = string
  default     = null
}

variable "ip_address" {
  description = "IP address to health check"
  type        = string
  default     = null
}

variable "port" {
  description = "Port to check"
  type        = number
  default     = 443
}

variable "type" {
  description = "Health check type (HTTP, HTTPS, TCP, HTTP_STR_MATCH, HTTPS_STR_MATCH)"
  type        = string
  default     = "HTTPS"
  validation {
    condition     = contains(["HTTP", "HTTPS", "TCP", "HTTP_STR_MATCH", "HTTPS_STR_MATCH"], var.type)
    error_message = "type must be HTTP, HTTPS, TCP, HTTP_STR_MATCH, or HTTPS_STR_MATCH."
  }
}

variable "resource_path" {
  description = "Path to check (e.g., /health)"
  type        = string
  default     = "/"
}

variable "failure_threshold" {
  description = "Number of consecutive failures before unhealthy"
  type        = number
  default     = 3
}

variable "request_interval" {
  description = "Seconds between health checks (10 or 30)"
  type        = number
  default     = 30
  validation {
    condition     = contains([10, 30], var.request_interval)
    error_message = "request_interval must be 10 or 30."
  }
}
