output "bucket_domain_name" {
  value       = aws_s3_bucket.default.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = aws_s3_bucket.default.id
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = aws_s3_bucket.default.arn
  description = "Bucket ARN"
}

output "readwrite_arn" {
  value       = aws_iam_policy.readwrite.arn
  description = "ARN of readwrite Policy"
}

output "readonly_arn" {
  value       = aws_iam_policy.readonly.arn
  description = "ARN of readonly Policy"
}

output "admin_arn" {
  value       = aws_iam_policy.admin.arn
  description = "ARN of admin Policy"
}

