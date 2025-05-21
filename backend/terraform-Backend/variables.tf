variable "cognito_admin_user_email" {
  type = string
}

variable "cognito_user_pool_domain" {
  type = string
}

variable "stripe_private_key" {
  type      = string
  sensitive = true
}

variable "stripe_webhook_secret" {
  type      = string
  sensitive = true
}

variable "opensearch_username" {
  type = string
}

variable "opensearch_password" {
  type      = string
  sensitive = true
}
variable "stripe_private_key" {
  description = "Stripe private key"
  type        = string
  sensitive   = true
}

variable "stripe_webhook_secret" {
  description = "Stripe webhook secret"
  type        = string
  sensitive   = true
}

variable "opensearch_username" {
  description = "OpenSearch username"
  type        = string
  sensitive   = true
}

variable "opensearch_password" {
  description = "OpenSearch password"
  type        = string
  sensitive   = true
}
variable "cognito_user_pool_domain" {
  description = "Cognito user pool domain prefix"
  type        = string
}