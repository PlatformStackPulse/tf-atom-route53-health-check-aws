output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the health check"
  value       = try(aws_route53_health_check.this[0].id, null)
}

output "arn" {
  description = "ARN of the health check"
  value       = try(aws_route53_health_check.this[0].arn, null)
}
