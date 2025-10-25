variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名(例: develop、staging、production)"
  type        = string
}

variable "aws_region" {
  description = "AWSリージョン"
  type        = string
}

variable "assume_role_arn" {
  description = "Terraform操作で引き受けるオプションのIAMロールARN"
  type        = string
  default     = null
}

variable "github_owner" {
  description = "GitHubの組織またはリポジトリを所有するユーザー名"
  type        = string
}

variable "github_repository" {
  description = "OIDC条件に使用されるGitHubリポジトリ名"
  type        = string
}

variable "cloudfront_alias_domain" {
  description = "CloudFrontが提供するプライマリアイラスドメイン"
  type        = string
}

variable "acm_lookup_domain" {
  description = "us-east-1でACM証明書を検索するために使用されるドメイン名"
  type        = string
}

variable "cloudfront_price_class" {
  description = "CloudFrontの価格クラス設定"
  type        = string
}

variable "cloudfront_default_root_object" {
  description = "CloudFrontディストリビューションのデフォルトルートオブジェクト"
  type        = string
}

variable "cloudfront_http_version" {
  description = "CloudFrontがサポートするHTTPプロトコルバージョン"
  type        = string
}

variable "cloudfront_cache_policy_id" {
  description = "CloudFrontのデフォルトキャッシュ動作に適用されるキャッシュポリシーID"
  type        = string
}

variable "cloudfront_origin_request_policy_id" {
  description = "CloudFrontに適用されるオリジンリクエストポリシーID"
  type        = string
}

variable "cloudfront_response_headers_policy_id" {
  description = "CloudFrontに適用されるレスポンスヘッダーポリシーID"
  type        = string
}

variable "default_tags" {
  description = "共通タグ"
  type        = map(string)
}

variable "github_oidc_thumbprint_list" {
  description = "GitHub OIDCプロバイダーの信頼されたサムプリント"
  type        = list(string)
  default = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
}
