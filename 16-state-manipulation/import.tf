
resource "aws_s3_bucket" "remote_state" {
  bucket = "weijie-test-123"

  tags = {
    ManagedBy = "Terraform"
    Lifecycle = "Critical"
  }
  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = "weijie-test-123"
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
