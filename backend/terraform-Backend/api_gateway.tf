# Cognito User Pool is defined separately in cognito.tf; here we just reference it.

# REST API Gateway
resource "aws_api_gateway_rest_api" "microservices_api" {
  name        = "MicroservicesAPI"
  description = "API Gateway for serverless microservices"
}

# Root Resource ID
data "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.microservices_api.id
  path        = "/"
}

# Example Resource: /orders
resource "aws_api_gateway_resource" "orders" {
  rest_api_id = aws_api_gateway_rest_api.microservices_api.id
  parent_id   = data.aws_api_gateway_resource.root.id
  path_part   = "orders"
}

# Method: GET /orders
resource "aws_api_gateway_method" "get_orders" {
  rest_api_id   = aws_api_gateway_rest_api.microservices_api.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

# Integration with Lambda for GET /orders
resource "aws_api_gateway_integration" "get_orders_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.microservices_api.id
  resource_id             = aws_api_gateway_resource.orders.id
  http_method             = aws_api_gateway_method.get_orders.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.order_service.invoke_arn
}

# Cognito User Pool Authorizer for API Gateway
resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name                    = "CognitoAuthorizer"
  rest_api_id             = aws_api_gateway_rest_api.microservices_api.id
  identity_source         = "method.request.header.Authorization"
  type                    = "COGNITO_USER_POOLS"
  provider_arns           = [aws_cognito_user_pool.user_pool.arn]
}

# Deployment
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.get_orders_lambda,
    aws_api_gateway_method.get_orders,
  ]

  rest_api_id = aws_api_gateway_rest_api.microservices_api.id
  stage_name  = var.stage_name  # Pass stage as a variable (e.g., dev, prod)
}


