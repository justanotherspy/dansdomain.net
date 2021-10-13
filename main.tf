data "aws_canonical_user_id" "current_user" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "dansdomain.net"

  tags = {
    "Description" = "S3 bucket for hosting dansdomain.net"
    "Name"        = "dansdomain.net"
  }

  grant {
    permissions = ["READ", "READ_ACP", "WRITE"]
    type        = "Group"
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
  grant {
    id          = data.aws_canonical_user_id.current_user.id
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
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

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "dansdomain-logs"
  tags   = {
    "Description" = "The S3 Bucket for the logs"
    "Name" = "dansdomain-logs"
  }

  grant {
    permissions = ["READ", "READ_ACP", "WRITE"]
    type        = "Group"
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
  grant {
    id          = data.aws_canonical_user_id.current_user.id
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }

  logging {
    target_bucket = "dansdomain-logs"
    target_prefix = "this/"
  }
}