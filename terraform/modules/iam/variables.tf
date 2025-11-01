variable "resource_prefix_iam_role" {
  description = "IAMロールリソースの接頭辞"
  type        = string
}

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_id" {
  description = "S3バケットのID"
  type        = string
}

variable "s3_bucket_arn" {
  description = "S3バケットのARN"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "CloudFrontディストリビューションのARN"
  type        = string
}

variable "iam_role_GitHubActionsRole" {
  description = "GitHub ActionsのOIDCと条件情報"
  type = object({
    federated     = string
    string_equals = map(string)
    string_like   = map(string)
  })
}

variable "iam_openid_GitHubActions" {
  description = "GitHubのOIDCプロバイダー情報"
  type = object({
    url             = string
    thumbprint_list = list(string)
  })
}
