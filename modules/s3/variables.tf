variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "index_document" {
  description = "The index document for the S3 bucket"
  type        = string
}

variable "error_document" {
  description = "The error document for the S3 bucket"
  type        = string
}

variable "cloudfront_arn" {
  description = "The ARN of the CloudFront distribution"
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket"
  type        = string
}
