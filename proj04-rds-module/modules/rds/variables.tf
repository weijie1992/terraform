variable "project_name" {
  type = string
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier access"
  }
}

variable "storage_size" {
  type    = number
  default = 10

  validation {
    condition     = var.storage_size > 5 && var.storage_size <= 10
    error_message = "DB storage must be between 5GB and 10 GB"
  }
}

variable "engine" {
  type    = string
  default = "postgres-latest"

  validation {
    condition     = contains(["postgres-latest", "postgres-14"], var.engine)
    error_message = "Database engine must be postgres-latest or postgres-14"
  }
}

variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0
      && length(regexall("[0-9]+", var.credentials.password)) > 0
      && length(regexall("^[a-zA-Z0-9+_?-]{6,}$", var.credentials.password)) > 0
    )
    error_message = <<-EOT
        Password must comply with the following format
        1. Contain at least 1 character 
        2. Contain at least 1 digit
        3. be at least 6 characters long. 
        4. Contain onlt the following characters: a-z, A-Z, 0-9, +,_,?, -.
        EOT
  }
}
