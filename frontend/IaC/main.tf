terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

# NEW: API ID passed from backend pipeline
variable "api_id" {
  type        = string
  description = "API Gateway HTTP API ID passed from backend pipeline"
}

data "aws_route53_zone" "mrbeefy" {
  name         = "mrbeefy.academy"
  private_zone = false
}

resource "aws_acm_certificate" "mrbeefy" {
  domain_name       = "mrbeefy.academy"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "mrbeefy_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.mrbeefy.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.mrbeefy.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.record]
}

resource "aws_route53_record" "mrbeefy_root" {
  zone_id = data.aws_route53_zone.mrbeefy.zone_id
  name    = "mrbeefy.academy"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.frontend.domain_name
    zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate_validation" "mrbeefy" {
  certificate_arn         = aws_acm_certificate.mrbeefy.arn
  validation_record_fqdns = [for r in aws_route53_record.mrbeefy_cert_validation : r.fqdn]
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "frontend" {
  bucket = "mrbeefy-frontend-${random_id.suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "frontend_oac" {
  name                              = "mrbeefy-frontend-oac"
  description                       = "OAC for Mr. Beefy frontend"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_iam_policy_document" "frontend_bucket_policy" {
  statement {
    sid    = "AllowCloudFrontOACRead"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.frontend.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.frontend.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  policy = data.aws_iam_policy_document.frontend_bucket_policy.json
}

resource "aws_cloudfront_cache_policy" "frontend" {
  name = "mrbeefy-frontend-cache-policy"

  default_ttl = 3600
  max_ttl     = 86400
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_response_headers_policy" "frontend" {
  name = "mrbeefy-frontend-security-headers"

  security_headers_config {
    content_type_options { override = true }

    frame_options {
      frame_option = "DENY"
      override     = true
    }

    referrer_policy {
      referrer_policy = "no-referrer-when-downgrade"
      override        = true
    }

    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains         = false
      preload                    = false
      override                   = true
    }

    xss_protection {
      mode_block = true
      protection = true
      override   = true
    }
  }
}

resource "aws_cloudfront_cache_policy" "api" {
  name = "mrbeefy-api-cache-policy"

  default_ttl = 0
  max_ttl     = 0
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_origin_request_policy" "api" {
  name = "mrbeefy-api-origin-request-policy"

  cookies_config {
    cookie_behavior = "none"
  }

  headers_config {
    header_behavior = "whitelist"

    headers {
      items = ["Content-Type"]
    }
  }

  query_strings_config {
    query_string_behavior = "all"
  }
}

resource "aws_cloudfront_distribution" "frontend" {
  depends_on = [
    aws_acm_certificate_validation.mrbeefy
  ]

  enabled             = true
  comment             = "Mr. Beefy frontend"
  default_root_object = "index.html"

  aliases = ["mrbeefy.academy"]

  # Origin 1: S3 frontend
  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "mrbeefy-frontend-origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.frontend_oac.id
  }

  # Origin 2: API Gateway HTTP API (dynamic)
  origin {
    domain_name = "${var.api_id}.execute-api.${data.aws_region.current.id}.amazonaws.com"
    origin_id   = "mrbeefy-api-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "mrbeefy-frontend-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id            = aws_cloudfront_cache_policy.frontend.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.frontend.id
  }

  ordered_cache_behavior {
    path_pattern           = "/chat"
    target_origin_id       = "mrbeefy-api-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id          = aws_cloudfront_cache_policy.api.id
    origin_request_policy_id = aws_cloudfront_origin_request_policy.api.id
 }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.mrbeefy.arn
    ssl_support_method  = "sni-only"
  }
}