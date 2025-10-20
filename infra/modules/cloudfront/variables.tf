variable "resource_prefix_cloudfront" {
  description = "CloudFrontリソースの接頭辞"
  type        = string
}

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}

variable "price_class" {
  description = "価格クラス"
  type        = string
}

variable "cloudfront_alias_domain" {
  description = "CloudFrontのエイリアスドメイン"
  type        = string
}

variable "default_root_object" {
  description = "CloudFrontのデフォルトルートオブジェクト"
  type        = string
}

variable "http_version" {
  description = "CloudFrontのHTTPバージョン"
  type        = string
}

variable "cache_policy_id" {
  description = "CloudFrontのキャッシュポリシーID"
  type        = string
}

variable "origin_request_policy_id" {
  description = "CloudFrontのオリジンリクエストポリシーID"
  type        = string
}

variable "response_headers_policy_id" {
  description = "CloudFrontのレスポンスヘッダーポリシーID"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "S3バケットのリージョナルドメイン名"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM証明書のARN"
  type        = string
}
