resource "aws_sqs_queue" "ctf_queue" {
  name = "Orbit_SQS"
  
}
data "aws_iam_policy_document" "test" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.ctf_queue.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [var.sns_topic_arn]
    }
  }
}
resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.ctf_queue.id
  policy    = data.aws_iam_policy_document.test.json
}

resource "aws_sns_topic_subscription" "sns_to_sqs" {
  topic_arn = var.sns_topic_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.ctf_queue.arn
} 