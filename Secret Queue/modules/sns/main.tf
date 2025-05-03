resource "aws_sns_topic" "ctf_topic" {
  name = var.topic_name
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.ctf_topic.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action = "SNS:Publish"
        Resource = aws_sns_topic.ctf_topic.arn
      }
    ]
  })
}
