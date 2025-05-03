resource "aws_iam_user" "api_stage_lister" {
  name = "api-stage-lister"
}

resource "aws_iam_access_key" "api_stage_lister" {
  user = aws_iam_user.api_stage_lister.name
}

resource "aws_iam_user_policy" "api_stage_lister" {
  name = "api-stage-lister-policy"
  user = aws_iam_user.api_stage_lister.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "apigateway:GET"
        ]
        Resource = [
          "${var.api_gateway_arn}/stages/*"
        ]
      }
    ]
  })
} 