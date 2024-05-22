terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.aws.access_key_id
  secret_key = var.aws.access_key_secret
}