FROM public.ecr.aws/lambda/python:3.11

# Hardcoded values injected by Terraform
ENV FLAG_API_URL="${flag_api_url}"
ENV API_KEY="${api_key}"

COPY lambda_function.py .

CMD ["lambda_function.lambda_handler"] 