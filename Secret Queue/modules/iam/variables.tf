variable "username" {
  description = "Username for the IAM user"
  type        = string
}

variable "sqs_queue_arn" {
  description = "ARN of the SQS queue"
  type        = string
} 