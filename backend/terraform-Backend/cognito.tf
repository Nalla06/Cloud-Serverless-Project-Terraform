resource "aws_cognito_user_pool" "shop_user_pool" {
  name = "simple-shop-user-pool"

  auto_verified_attributes = ["email"]

  username_attributes = ["email"]

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = true
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }

  tags = {
    Environment = "dev"
    Name        = "SimpleShopUserPool"
  }
}

resource "aws_cognito_user_pool_client" "shop_user_pool_client" {
  name         = "simple-shop-client"
  user_pool_id = aws_cognito_user_pool.shop_user_pool.id

  generate_secret           = false
  explicit_auth_flows       = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows       = ["code"]
  allowed_oauth_scopes      = ["openid", "email", "profile"]
  callback_urls             = ["https://yourdomain.com/callback"]
  logout_urls               = ["https://yourdomain.com/logout"]
  allowed_oauth_flows_user_pool_client = true
}

resource "aws_cognito_user_pool_domain" "shop_user_pool_domain" {
  domain       = var.cognito_user_pool_domain
  user_pool_id = aws_cognito_user_pool.shop_user_pool.id
}


