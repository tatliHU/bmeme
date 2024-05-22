variable region {
  type    = string
  default = "eu-north-1"
}

variable aws {
  type    = object({
    access_key_id     = string
    access_key_secret = string
  })
}