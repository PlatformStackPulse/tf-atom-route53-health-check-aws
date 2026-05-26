resource "aws_route53_health_check" "this" {
  count = module.this.enabled ? 1 : 0

  fqdn              = var.fqdn
  ip_address        = var.ip_address
  port              = var.port
  type              = var.type
  resource_path     = var.resource_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval

  tags = module.this.tags
}
