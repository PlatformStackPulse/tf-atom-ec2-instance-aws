# Unit Tests for tf-atom-ec2-instance-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# All assertions are on plan-KNOWN values (tf-label id, resource count,
# input pass-throughs) — NOT on computed arn/id which are unknown under
# a mock provider.
#
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run specific:     terraform test -test-directory=tests/unit -run "creates_when_enabled"

mock_provider "aws" {}

variables {
  # tf-label identity
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-required inputs
  ami       = "ami-0123456789abcdef0"
  subnet_id = "subnet-0123456789abcdef0"
}

# ---------------------------------------------------------------------------
# Test: module creates the instance when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be 'eg-test-thing' for the given namespace/stage/name."
  }

  assert {
    condition     = length(aws_instance.this) == 1
    error_message = "Exactly one aws_instance should be planned when the module is enabled."
  }

  assert {
    condition     = aws_instance.this[0].ami == "ami-0123456789abcdef0"
    error_message = "aws_instance.ami should equal the ami input."
  }

  assert {
    condition     = aws_instance.this[0].instance_type == "t3.micro"
    error_message = "instance_type should default to t3.micro."
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
    condition     = length(aws_instance.this) == 0
    error_message = "No aws_instance should be planned when enabled = false."
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled."
  }

  assert {
    condition     = output.arn == null
    error_message = "arn output should be null when the module is disabled."
  }
}
