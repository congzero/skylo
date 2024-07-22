output "s3_bucket_website_url" {
  value = module.s3.bucket_website_url
}

output "cloudfront_domain_name" {
  value = module.cloudfront.domain_name
}

output "route53_zone_id" {
  value = module.route53.zone_id
}
