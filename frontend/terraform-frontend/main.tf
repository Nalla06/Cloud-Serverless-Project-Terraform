provider "aws" {
  region = "us-east-1"
}

# S3 bucket for hosting React app
resource "aws_s3_bucket" "react_frontend" {
  bucket = "my-react-app-bucket"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = "ReactFrontendBucket"
  }
}

# Enable public access to the bucket (if not using CloudFront signed URLs)
resource "aws_s3_bucket_public_access_block" "react_frontend" {
  bucket = aws_s3_bucket.react_frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy for public read access
resource "aws_s3_bucket_policy" "react_frontend_policy" {
  bucket = aws_s3_bucket.react_frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.react_frontend.arn}/*"
        ]
      }
    ]
  })
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "react_cdn" {
  origin {
    domain_name = aws_s3_bucket.react_frontend.website_endpoint
    origin_id   = "S3-react-frontend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-react-frontend"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "ReactFrontendCDN"
  }
}
