variable tags {
  type    = map(string)
  default = {
    "ManagedBy" = "Terraform"
  }
}

variable function_name {
  type    = string
  default = "test"
}

variable code {
  type    = string
}