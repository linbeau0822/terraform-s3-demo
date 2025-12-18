# S3 bucket to hold website files. Uses a random suffix for a unique name.
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    name        = "My bucket - ${var.environment}"
    environment = var.environment
  }
}

# CloudFront Origin Access Identity (OAI) granting CloudFront a canonical user
# that can be allowed to access the S3 bucket privately (no public access required).
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${aws_s3_bucket.example.id}"
}

# IAM policy document that grants the CloudFront OAI permission to read
# objects (`s3:GetObject`) from the S3 bucket.
data "aws_iam_policy_document" "cf_oai_policy" {
  statement {
    sid = "AllowCloudFrontRead"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.example.arn}/*"]
  }
}

# Attach the generated IAM policy to the S3 bucket so only the CloudFront
# OAI can read the bucket objects (prevents public access while allowing CDN).
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.example.id

  policy = data.aws_iam_policy_document.cf_oai_policy.json
}

# CloudFront distribution that serves the S3 bucket via the OAI. Configures
# default root object, cache behavior, TLS (default certificate), and pricing.
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = var.root_source_path

  origin {
    domain_name = aws_s3_bucket.example.bucket_regional_domain_name
    origin_id   = "s3-${aws_s3_bucket.example.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-${aws_s3_bucket.example.id}"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  price_class = "PriceClass_100"

  # If we want to restrict to certain countries/regions, we can change this section.
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "example-cdn"
  }
}