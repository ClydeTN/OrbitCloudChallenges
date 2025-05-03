terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}

module "ecr" {
  source = "./modules/ecr"
  flag_api_url = module.api_gateway.api_endpoint
  api_key      = module.api_gateway.api_key
  ecr_repo_url = module.ecr.ecr_repo_url
  region       = "us-east-1"
}

module "lambda" {
  source = "./modules/lambda"
  lambda_image_uri = module.ecr.image_uri
}

module "iam_user" {
  source = "./modules/iam_user"
  api_gateway_arn = module.api_gateway.api_arn
} 