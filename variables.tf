variable "ami" {
  description = "AMI ID for the instance"
  type        = string
  validation {
    condition     = length(var.ami) > 0
    error_message = "ami must not be empty."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID of the subnet to launch in"
  type        = string
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "subnet_id must not be empty."
  }
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script (plain text)"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "User data script (base64 encoded)"
  type        = string
  default     = null
}

variable "root_volume_type" {
  description = "Root volume type (gp3, gp2, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "monitoring_enabled" {
  description = "Whether detailed monitoring is enabled"
  type        = bool
  default     = true
}
