output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.ctf_queue.arn
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.ctf_queue.url
} 