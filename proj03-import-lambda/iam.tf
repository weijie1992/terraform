import {
  to = aws_iam_role.lambda_execution_role
  id = "weijie-manually-create-role-7avuav4o"
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  managed_policy_arns = ["arn:aws:iam::479833041972:policy/service-role/AWSLambdaBasicExecutionRole-7e2ad7db-cf75-449b-be59-36f7b8ecf25c"]
  name                = "weijie-manually-create-role-7avuav4o"
  path                = "/service-role/"
}
