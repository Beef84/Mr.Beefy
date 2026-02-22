output "frontend_bucket_name" {
  description = "S3 bucket name for the frontend assets"
  value       = aws_s3_bucket.frontend.bucket
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name for the frontend"
  value       = aws_cloudfront_distribution.frontend.domain_name
}