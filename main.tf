# -----------------------------------------------------------------------------
# tf-atom-route53-health-check-aws
#
# Single-resource atom: one aws_route53_health_check, gated by the standard
# `enabled` flag from context.tf.
# -----------------------------------------------------------------------------

resource "aws_route53_health_check" "this" {
  count = local.enabled ? 1 : 0

  type              = var.type
  fqdn              = var.fqdn
  ip_address        = var.ip_address
  port              = var.port
  resource_path     = var.resource_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval

  tags = local.tags
}
