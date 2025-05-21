resource "aws_ssm_parameter" "cognito_admin_email" {
  name  = "/services/cognito/CognitoAdminlUserEmail"
  type  = "String"
  value = "admin@example.com"
}

resource "aws_ssm_parameter" "cognito_user_pool_domain" {
  name  = "/services/cognito/CognitoUserPoolDomain"
  type  = "String"
  value = "your-user-pool-domain"
}

resource "aws_ssm_parameter" "stripe_private_key" {
  name  = "/services/stripe/StripePrivateKey"
  type  = "SecureString"
  value = var.stripe_private_key
}

resource "aws_ssm_parameter" "stripe_webhook_secret" {
  name  = "/services/stripe/StripeWebhookSecret"
  type  = "SecureString"
  value = var.stripe_webhook_secret
}

resource "aws_ssm_parameter" "opensearch_username" {
  name  = "/services/opensearch/username"
  type  = "SecureString"
  value = var.opensearch_username
}

resource "aws_ssm_parameter" "opensearch_password" {
  name  = "/services/opensearch/password"
  type  = "SecureString"
  value = var.opensearch_password
}

