terraform {
  required_version = ">= 1.0.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "dansdomain"
    workspaces {
      name = "dansdomainnet"
    }
  }
}

provider "aws" {
  region = "${var.region}"
}

variable "region" {
  type = string
  description = "Region"
  default = "eu-west-1"
}