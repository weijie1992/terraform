removed {
  from = aws_s3_bucket.my_bucket
  lifecycle {
    destroy = false
  }
}

# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "weijie-akjsdk123-2"
# }
