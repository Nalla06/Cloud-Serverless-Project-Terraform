resource "aws_cloudwatch_log_group" "lambda_log_group_checkout" {
  name              = "/aws/lambda/${aws_lambda_function.checkout_lambda.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "lambda_log_group_order" {
  name              = "/aws/lambda/${aws_lambda_function.order_lambda.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "lambda_log_group_cart" {
  name              = "/aws/lambda/${aws_lambda_function.cart_lambda.function_name}"
  retention_in_days = 14
}
