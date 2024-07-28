import {
  to = aws_cloudwatch_log_group.lambda
  id = "/aws/lambda/weijie-manually-create"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/weijie-manually-create"
}
