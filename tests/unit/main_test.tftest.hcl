# Unit Tests for tf-atom-route53-health-check-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# All assertions target plan-KNOWN values (the tf-label id string and
# input pass-throughs), never computed arn/id values that are unknown
# under a mock provider.
#
# Run with:  terraform test -test-directory=tests/unit
# Verbose:   terraform test -test-directory=tests/unit -verbose

mock_provider "aws" {}

variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
}

# ---------------------------------------------------------------------------
# Test: module is enabled and produces the expected tf-label id
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled == true when enabled defaults to true."
  }

  assert {
    condition     = output.id == "eg-test-thing"
    error_message = "tf-label id should be composed as namespace-stage-name (eg-test-thing)."
  }

  assert {
    condition     = output.tags["Namespace"] == "eg" && output.tags["Stage"] == "test" && output.tags["Name"] == "eg-test-thing"
    error_message = "tf-label tags should reflect the provided namespace, stage, and generated name."
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled == false when enabled = false."
  }

  assert {
    condition     = output.id == ""
    error_message = "tf-label id should be empty when the module is disabled."
  }
}
