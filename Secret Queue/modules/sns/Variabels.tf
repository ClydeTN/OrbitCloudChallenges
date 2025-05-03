variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}
variable "ctf_queue" {
  description = "SQS queue to subscribe to the SNS topic"
  type        = any
}