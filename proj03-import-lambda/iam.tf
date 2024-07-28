# import {
#   to = aws_iam_role.lambda_execution_role
#   id = "weijie-manually-create-role-7avuav4o"
# }

# import {
#   to = aws_iam_policy.lambda_execution
#   id = "arn:aws:iam::479833041972:policy/service-role/AWSLambdaBasicExecutionRole-7e2ad7db-cf75-449b-be59-36f7b8ecf25c"
# }

data "aws_iam_policy_document" "assume_lambda_execution_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_execution_role.json
  name               = "weijie-manually-create-role-7avuav4o"
  path               = "/service-role/"
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "lambda_execution" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    effect    = "Allow"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }

  statement {
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    effect    = "Allow"
    resources = ["${aws_cloudwatch_log_group.lambda.arn}:*"]
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name   = "AWSLambdaBasicExecutionRole-7e2ad7db-cf75-449b-be59-36f7b8ecf25c"
  path   = "/service-role/"
  policy = data.aws_iam_policy_document.lambda_execution.json
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}
