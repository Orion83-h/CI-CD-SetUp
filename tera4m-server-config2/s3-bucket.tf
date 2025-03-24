resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 Bucket for Trivy Reports
resource "aws_s3_bucket" "trivy_reports" {
  bucket = "trivy-reports-${random_string.bucket_suffix.result}"

  # object_lock disabled
  object_lock_enabled = false  

  tags = {
    Name    = var.bucket_tag
    Purpose = "Trivy Report Store"
  }
}

# Enable versioning - required for lifecycle management
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.trivy_reports.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle Policy for Trivy Reports
resource "aws_s3_bucket_lifecycle_configuration" "trivy_reports_lifecycle" {
  bucket = aws_s3_bucket.trivy_reports.id

  rule {
    id     = "expire-trivy-reports"
    status = "Enabled"

    filter {
      prefix = "trivy-reports/"
    }

    expiration {
      days = 7
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }

  rule {
    id     = "remove-delete-markers"
    status = "Enabled"

    filter {
      prefix = "trivy-reports/"
    }

    expiration {
      expired_object_delete_marker = true
    }
  }
}
