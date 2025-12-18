output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.static_site.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.static_site.cloudfront_distribution_id
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.static_site.s3_bucket_name
}

