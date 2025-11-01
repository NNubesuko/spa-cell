output "cloudfront_distribution_arn" {
  description = "CloudFrontディストリビューションのARN"
  value       = aws_cloudfront_distribution.this.arn
}
