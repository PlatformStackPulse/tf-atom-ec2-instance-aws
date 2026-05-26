resource "aws_instance" "this" {
  count = module.this.enabled ? 1 : 0

  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile
  user_data              = var.user_data
  user_data_base64       = var.user_data_base64

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true
  }

  monitoring = var.monitoring_enabled

  tags = merge(module.this.tags, { Name = module.this.id })
}
