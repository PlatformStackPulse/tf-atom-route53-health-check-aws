output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "The tf-label generated ID used for resource naming (e.g. \"namespace-stage-name\")."
  value       = module.this.id
}

output "tags" {
  description = "The normalized tags map produced by tf-label, applied to all resources."
  value       = local.tags
}
