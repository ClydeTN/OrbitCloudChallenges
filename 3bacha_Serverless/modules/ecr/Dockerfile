FROM amazon/aws-lambda-python:latest

# Copy requirements.txt and install packages
COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip install -r requirements.txt

# Copy function code
COPY lambda_function.py ${LAMBDA_TASK_ROOT}

# Set environment variables (can be overridden during deployment)
ENV API_URL="https://0xh8zq2fmf.execute-api.eu-central-1.amazonaws.com/prod/SouassiFlag"
ENV API_KEY="m3JK2A4mJOQ5fEgcND6V4aMkzh112FG68GYiFN4i"

# Set the Lambda handler
CMD [ "lambda_function.handler" ]
