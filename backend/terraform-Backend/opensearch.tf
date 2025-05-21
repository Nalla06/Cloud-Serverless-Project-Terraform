resource "aws_opensearch_domain" "shop_search" {
  domain_name           = "simple-shop-search"
  engine_version        = "OpenSearch_2.11"

  cluster_config {
    instance_type = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp2"
  }

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "es:*"
        Resource  = "arn:aws:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/simple-shop-search/*"
      }
    ]
  })

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.opensearch_username
      master_user_password = var.opensearch_password
    }
  }

  tags = {
    Name        = "SimpleShopSearch"
    Environment = "dev"
  }
}

variable "opensearch_username" {
  description = "OpenSearch master username"
  type        = string
}

variable "opensearch_password" {
  description = "OpenSearch master password"
  type        = string
  sensitive   = true
}

data "aws_caller_identity" "current" {}
