variable "lambda_image_uri" {
  description = "The ECR image URI for the Lambda function"
  type        = string
}

resource "aws_lambda_function" "souassi_lambda" {
  function_name = "Souassilambda"
  package_type  = "Image"
  image_uri     = var.lambda_image_uri
  role          = aws_iam_role.lambda_exec.arn
  timeout       = 10
}

resource "aws_iam_role" "lambda_exec" {
  name = "souassi-lambda-exec"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.souassi_lambda.invoke_arn
} 