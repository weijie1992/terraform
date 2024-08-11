variable "terraform_cloud_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "Terraform Cloud hostname, without https://"
}

variable "terraform_cloud_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "Terraform Cloud Audience use to authenticate"
}

