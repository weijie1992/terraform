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
  role             = aws_iam_role.lambda_execution_role.arn
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
