terraform {
  required_providers {
    aws = {
      version = "~> 5.27.0"
    }
  }
}

provider "aws" {
  region = "${var.region}"
}