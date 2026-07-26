# -----------------------------------------------------------------------------
# Module-Specific Variables
#
# Note: Standard labeling variables (enabled, namespace, tenant, environment,
# stage, name, delimiter, attributes, tags, label_order, etc.) are provided
# by context.tf via the tf-label module.
# -----------------------------------------------------------------------------

variable "type" {
  description = "Protocol/type of the health check."
  type        = string

  validation {
    condition = contains(
      ["HTTP", "HTTPS", "HTTP_STR_MATCH", "HTTPS_STR_MATCH", "TCP", "CALCULATED", "CLOUDWATCH_METRIC"],
      var.type
    )
    error_message = "type must be one of: HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED, CLOUDWATCH_METRIC."
  }
}

variable "fqdn" {
  description = "Fully qualified domain name of the endpoint to health check."
  type        = string
  default     = null
}

variable "ip_address" {
  description = "IP address of the endpoint to health check."
  type        = string
  default     = null
}

variable "port" {
  description = "Port of the endpoint to health check."
  type        = number
  default     = null
}

variable "resource_path" {
  description = "Path that the health check requests when checking HTTP/HTTPS endpoints."
  type        = string
  default     = null
}

variable "failure_threshold" {
  description = "Number of consecutive failures before considering the endpoint unhealthy."
  type        = number
  default     = 3

  validation {
    condition     = var.failure_threshold >= 1 && var.failure_threshold <= 10
    error_message = "failure_threshold must be between 1 and 10."
  }
}

variable "request_interval" {
  description = "Number of seconds between health check requests (10 or 30)."
  type        = number
  default     = 30

  validation {
    condition     = contains([10, 30], var.request_interval)
    error_message = "request_interval must be either 10 or 30."
  }
}
