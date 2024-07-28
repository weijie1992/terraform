import {
  to = aws_lambda_function.this
  id = "weijie-manually-create"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.mjs"
  output_path = "${path.root}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  description      = "A starter AWS Lambda function."
  filename         = "lambda.zip"
  function_name    = "weijie-manually-create"
  handler          = "index.handler"
  role             = "arn:aws:iam::479833041972:role/service-role/weijie-manually-create-role-7avuav4o"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  tags = {
    "lambda-console:blueprint" = "hello-world"
  }
  logging_config {
    application_log_level = null
    log_format            = "Text"
    log_group             = "/aws/lambda/weijie-manually-create"
  }
}
