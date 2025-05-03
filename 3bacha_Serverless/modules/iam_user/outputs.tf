output "access_key_id" {
  description = "Access key ID for the API stage lister user"
  value       = aws_iam_access_key.api_stage_lister.id
}

output "secret_access_key" {
  description = "Secret access key for the API stage lister user"
  value       = aws_iam_access_key.api_stage_lister.secret
} 