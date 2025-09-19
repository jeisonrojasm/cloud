terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
  required_version = "1.13.2"
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
  default_tags {
    tags = var.tags
  }
}
