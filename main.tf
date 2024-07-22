terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

provider "random" {
  # 랜덤 제공자를 사용하여 고유한 문자열을 생성
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

module "s3" {
  source          = "./modules/s3"
  bucket_name     = var.bucket_name
  index_document  = var.index_document
  error_document  = var.error_document
  bucket_arn      = var.bucket_arn
  cloudfront_arn  = module.cloudfront.cloudfront_arn


}

module "cloudfront" {
  source            = "./modules/cloudfront"
  origin_domain_name = module.s3.bucket_regional_domain_name
  index_document     = var.index_document
}

module "route53" {
  source             = "./modules/route53"
  domain_name        = "yourdomain.com"
  cloudfront_domain  = module.cloudfront.domain_name
  cloudfront_zone_id = module.cloudfront.hosted_zone_id
}

