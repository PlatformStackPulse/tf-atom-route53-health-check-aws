output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "The id of the Route53 health check."
  value       = try(aws_route53_health_check.this[0].id, null)
}

output "arn" {
  description = "The ARN of the Route53 health check."
  value       = try(aws_route53_health_check.this[0].arn, null)
}
