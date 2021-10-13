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

resource "aws_s3_bucket" "logs_bucket" {
  bucket         = "dansdomain-logs"
  hosted_zone_id = "Z1BKCTXD74EZPE"
  tags           = {}

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
  grant {
    id = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
    permissions = [
      "FULL_CONTROL",
    ]
    type = "CanonicalUser"
  }

  logging {
    target_bucket = "dansdomain-logs"
    target_prefix = "this/"
  }

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled    = false
    mfa_delete = false
  }
}