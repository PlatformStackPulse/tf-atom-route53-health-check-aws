mock_provider "aws" {}

# Standard tf-label inputs shared by every run block below.
variables {
  namespace     = "eg"
  stage         = "test"
  name          = "thing"
  type          = "HTTPS"
  fqdn          = "api.example.com"
  port          = 443
  resource_path = "/healthz"
}

run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled = true when enabled is left at its default."
  }

  assert {
    condition     = length(aws_route53_health_check.this) == 1
    error_message = "Exactly one aws_route53_health_check should be planned when enabled."
  }

  assert {
    condition     = aws_route53_health_check.this[0].type == "HTTPS"
    error_message = "type should be passed through to the resource."
  }
}

run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when enabled = false is passed."
  }

  assert {
    condition     = length(aws_route53_health_check.this) == 0
    error_message = "No aws_route53_health_check should be planned when disabled."
  }

  assert {
    condition     = output.id == null && output.arn == null
    error_message = "id and arn outputs should be null when the module is disabled."
  }
}
