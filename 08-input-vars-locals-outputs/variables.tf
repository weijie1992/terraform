variable "ec2_instance_type" {
  type = string

  validation {
    # condition     = var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only supports t2.micro and t3.micro"
  }
  description = "The size of manage EC2 instance"
}
variable "ec2_volume_size" {
  type        = number
  description = "The size of the root block volume attached to managed EC2 instances"
  default     = 10
}

variable "ec2_volume_type" {
  type        = string
  description = "The volume type between gp2 and gp3."
  default     = "gp3"
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })

  description = "The size and type of volume"
  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type = map(string)
  default = {
  }
}


