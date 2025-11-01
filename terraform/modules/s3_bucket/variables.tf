variable "resource_prefix_s3_bucket" {
  description = "S3バケットリソースの接頭辞"
  type        = string
}

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}
