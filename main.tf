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
  region = "eu-west-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket         = "dansdomain.net"
  hosted_zone_id = "Z1BKCTXD74EZPE"
  tags = {
    "Description" = "S3 bucket for hosting dansdomain.net"
    "Name"        = "dansdomain.net"
  }

  grant {
    permissions = [
      "READ",
      "READ_ACP",
      "WRITE",
    ]
    type = "Group"
    uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
  grant {
    id = "3e941c5462d8291b29f34e21d7a24877ce7b077e7c34fe52e5728329c221c281"
    permissions = [
      "FULL_CONTROL",
    ]
    type = "CanonicalUser"
  }

  logging {
    target_bucket = "dansdomain-logs"
    target_prefix = "access_logs/"
  }

  versioning {
    enabled    = true
    mfa_delete = false
  }

  website {
    error_document = "index.html"
    index_document = "index.html"
  }
}