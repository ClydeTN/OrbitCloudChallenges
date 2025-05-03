variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "sns_topic_name" {
  description = "Name of the SNS topic"
  type        = string
  default     = "Orbit_SNS_TOPIC"
}

variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "Orbit_SQS_queue"
}

variable "iam_username" {
  description = "Username for the IAM user"
  type        = string
  default     = "Orbit_SQS_SNS_user"
}

