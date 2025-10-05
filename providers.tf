terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">4.43.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws"{
    region = "eu-west-3"
    default_tags {
      tags = var.tags
    }
    access_key = var.access_key
    secret_key = var.secret_key
}
