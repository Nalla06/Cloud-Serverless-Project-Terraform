# IAM Role for Lambda functions (can be referenced in iam.tf later too)


# Attach managed policies for Lambda logging and DynamoDB, SSM access (adjust as needed)
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_access" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"  # restrict in prod!
}

resource "aws_iam_role_policy_attachment" "lambda_ssm_access" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_eventbridge_access" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
}

# Example Lambda function - Change "filename.zip" and handler accordingly
resource "aws_lambda_function" "order_service" {
  function_name = "order-service"
  filename      = "lambda/order-service.zip"    # path to your zipped lambda code
  handler       = "main"                         # for Go this is usually 'main'
  runtime       = "go1.x"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10
  memory_size   = 128

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.orders.name
      # Add other env vars here or from SSM later
    }
  }
}

resource "aws_lambda_function" "checkout_service" {
  function_name = "checkout-service"
  filename      = "lambda/checkout-service.zip"
  handler       = "main"
  runtime       = "go1.x"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10
  memory_size   = 128

  environment {
    variables = {
      # Your environment variables here
    }
  }
}

# Add other Lambda functions similarly
