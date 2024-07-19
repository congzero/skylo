# OAC
resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "S3-OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.origin_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
    origin_id   = "S3-website"

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "S3 CloudFront distribution"
  default_root_object = var.index_document

  default_cache_behavior {
    target_origin_id       = "S3-website"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

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

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "hosted_zone_id" {
  value = aws_cloudfront_distribution.cdn.hosted_zone_id
}


output "cloudfront_arn" {
  value = aws_cloudfront_distribution.cdn.arn
}
