variable "subnet_count" {
  type    = number
  default = 2
}
variable "ec2_instance_count" {
  type    = number
  default = 4
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  validation {
    condition     = alltrue([for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)])
    error_message = "Only t2.micro is allow"
  }
  validation {
    condition     = alltrue([for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)])
    error_message = "Only Ubuntu and Nginx ami are allow"
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_index  = optional(number, 0)
  }))
  validation {
    condition     = alltrue([for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)])
    error_message = "Only t2.micro is allow"
  }
  validation {
    condition     = alltrue([for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)])
    error_message = "Only Ubuntu and Nginx ami are allow"
  }
}
