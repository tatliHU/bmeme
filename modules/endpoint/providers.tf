terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50.0"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}