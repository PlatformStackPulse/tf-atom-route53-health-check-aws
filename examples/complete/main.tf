# -----------------------------------------------------------------------------
# Complete example: tf-atom-route53-health-check-aws
# -----------------------------------------------------------------------------

provider "aws" {
  region = "us-east-1"
}

module "route53_health_check" {
  source = "../../"

  namespace   = "eg"
  environment = "use1"
  stage       = "app"
  name        = "api"

  type              = "HTTPS"
  fqdn              = "api.example.com"
  port              = 443
  resource_path     = "/healthz"
  failure_threshold = 3
  request_interval  = 30

  tags = {
    Team = "platform"
  }
}

output "health_check_id" {
  description = "Id of the Route53 health check."
  value       = module.route53_health_check.id
}
