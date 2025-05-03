variable "flag_api_url" {
  description = "The API Gateway flag resource URL"
  type        = string
}

variable "api_key" {
  description = "The API key for the API Gateway"
  type        = string
}

variable "ecr_repo_url" {
  description = "The ECR repository URL"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
} 