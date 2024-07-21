variable "vpc_cidr" {
  type = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The variable vpc_cidr must contain a valid CIDR block."
  }
}
