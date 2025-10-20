variable "project_name" {
  description = "Base project identifier used for resource naming."
  type        = string
}

variable "environment" {
  description = "Short environment name (e.g. develop, staging, production)."
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources are created."
  type        = string
}

variable "assume_role_arn" {
  description = "Optional IAM role ARN to assume for Terraform actions."
  type        = string
  default     = null
}

variable "github_owner" {
  description = "GitHub organisation or user owning the repository."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name used for OIDC conditions."
  type        = string
}

variable "cloudfront_alias_domain" {
  description = "Primary alias domain served by CloudFront."
  type        = string
}

variable "acm_lookup_domain" {
  description = "Domain name used to lookup the ACM certificate in us-east-1."
  type        = string
}

variable "cloudfront_price_class" {
  description = "CloudFront price class setting."
  type        = string
}

variable "cloudfront_default_root_object" {
  description = "Default root object for the CloudFront distribution."
  type        = string
}

variable "cloudfront_http_version" {
  description = "HTTP protocol version supported by CloudFront."
  type        = string
}

variable "cloudfront_cache_policy_id" {
  description = "Cache policy ID applied to CloudFront default cache behaviour."
  type        = string
}

variable "cloudfront_origin_request_policy_id" {
  description = "Origin request policy ID applied to CloudFront."
  type        = string
}

variable "cloudfront_response_headers_policy_id" {
  description = "Response headers policy ID applied to CloudFront."
  type        = string
}

variable "default_tags" {
  description = "Default tags applied to supported AWS resources."
  type        = map(string)
}

variable "github_oidc_thumbprint_list" {
  description = "Trusted thumbprints for the GitHub OIDC provider."
  type        = list(string)
  default = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
}
