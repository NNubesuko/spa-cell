output "bucket_id" {
  description = "S3バケットのID"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "S3バケットのARN"
  value       = aws_s3_bucket.this.arn
}

output "bucket_name" {
  description = "S3バケットの名前"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_regional_domain_name" {
  description = "S3バケットのリージョナルドメイン名"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
