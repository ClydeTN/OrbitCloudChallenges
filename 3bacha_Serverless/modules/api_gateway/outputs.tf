output "api_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.vulnerable_api.id
}

output "api_arn" {
  description = "The ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.vulnerable_api.arn
}

output "api_key" {
  description = "The API key value"
  value       = aws_api_gateway_api_key.api_key.value
  sensitive   = true
}

output "api_endpoint" {
  description = "The base URL of the API Gateway"
  value       = aws_api_gateway_stage.prod.invoke_url
}

output "api_stage_lister_access_key" {
  description = "Access key ID for the API stage lister user"
  value       = aws_iam_access_key.api_stage_lister.id
}

output "api_stage_lister_secret_key" {
  description = "Secret access key for the API stage lister user"
  value       = aws_iam_access_key.api_stage_lister.secret
} 