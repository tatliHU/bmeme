import base64

def lambda_handler(event, context):
    with open('index.html', 'r') as file:
        html_content = file.read()
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'text/html'
        },
        'body': html_content
    }