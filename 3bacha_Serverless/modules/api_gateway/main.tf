resource "aws_api_gateway_rest_api" "vulnerable_api" {
  name        = "vulnerable-api"
  description = "Vulnerable API for CTF challenge"
}

resource "aws_api_gateway_resource" "souassi_lambda" {
  rest_api_id = aws_api_gateway_rest_api.vulnerable_api.id
  parent_id   = aws_api_gateway_rest_api.vulnerable_api.root_resource_id
  path_part   = "SouassiLambda"
}

resource "aws_api_gateway_resource" "souassi_flag" {
  rest_api_id = aws_api_gateway_rest_api.vulnerable_api.id
  parent_id   = aws_api_gateway_rest_api.vulnerable_api.root_resource_id
  path_part   = "SouassiFlag"
}

resource "aws_api_gateway_method" "souassi_lambda_get" {
  rest_api_id   = aws_api_gateway_rest_api.vulnerable_api.id
  resource_id   = aws_api_gateway_resource.souassi_lambda.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_method" "souassi_flag_get" {
  rest_api_id   = aws_api_gateway_rest_api.vulnerable_api.id
  resource_id   = aws_api_gateway_resource.souassi_flag.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "souassi_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vulnerable_api.id
  resource_id             = aws_api_gateway_resource.souassi_lambda.id
  http_method             = aws_api_gateway_method.souassi_lambda_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_integration" "souassi_flag_integration" {
  rest_api_id             = aws_api_gateway_rest_api.vulnerable_api.id
  resource_id             = aws_api_gateway_resource.souassi_flag.id
  http_method             = aws_api_gateway_method.souassi_flag_get.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200,
  "body": "{\"flag\": \"Flag[S0ouSii}\"}"
}
EOF
  }
}

resource "aws_api_gateway_method_response" "souassi_flag_response" {
  rest_api_id = aws_api_gateway_rest_api.vulnerable_api.id
  resource_id = aws_api_gateway_resource.souassi_flag.id
  http_method = aws_api_gateway_method.souassi_flag_get.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "souassi_flag_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.vulnerable_api.id
  resource_id = aws_api_gateway_resource.souassi_flag.id
  http_method = aws_api_gateway_method.souassi_flag_get.http_method
  status_code = aws_api_gateway_method_response.souassi_flag_response.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_deployment" "prod" {
  depends_on = [
    aws_api_gateway_integration.souassi_lambda_integration,
    aws_api_gateway_integration.souassi_flag_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.vulnerable_api.id
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.prod.id
  rest_api_id   = aws_api_gateway_rest_api.vulnerable_api.id
  stage_name    = "prod"
}

resource "aws_api_gateway_api_key" "api_key" {
  name = "vulnerable-api-key"
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "vulnerable-api-usage-plan"
  api_stages {
    api_id = aws_api_gateway_rest_api.vulnerable_api.id
    stage  = aws_api_gateway_stage.prod.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}

