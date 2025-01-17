variable "origin_domain_name" {
  description = "The domain name of the origin S3 bucket"
  type        = string
}

variable "index_document" {
  description = "The index document for the CloudFront distribution"
  type        = string
}
