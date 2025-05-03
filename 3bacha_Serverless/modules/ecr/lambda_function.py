import os
import json
import urllib3

http = urllib3.PoolManager()

def handler(event, context):
    api_url = os.environ.get("API_URL")
    api_key = os.environ.get("API_KEY")

    if not api_url or not api_key:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Missing API_URL or API_KEY in environment variables"})
        }

    try:
        response = http.request(
            'GET',
            api_url,
            headers={
                "x-api-key": api_key
            }
        )

        data = json.loads(response.data.decode('utf-8'))
        flag = data.get("flag", "No flag found")

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": f"{flag}, thank you for participating"
            }),
            "headers": {
                "Content-Type": "application/json"
            }
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

