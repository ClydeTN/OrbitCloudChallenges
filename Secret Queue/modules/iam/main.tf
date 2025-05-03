resource "aws_iam_user" "ctf_user" {
  name = var.username
}

resource "aws_iam_access_key" "ctf_user_key" {
  user = aws_iam_user.ctf_user.name
}

resource "aws_iam_user_policy" "ctf_user_policy" {
  name = "ctf_challenge_policy"
  user = aws_iam_user.ctf_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = [var.sqs_queue_arn]
      }
    ]
  })
} 