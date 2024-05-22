import base64

def lambda_handler(event, context):
    try:
        username, password = extract_basic_auth(event)
        return {
            'statusCode': 200,
            'body': f'Username: {username}, Password: {password}'
        }
    except Exception as e:
        return {
            'statusCode': 401,
            'body': 'Unauthorized: ' + str(e)
        }

def extract_basic_auth(event):
    auth_header = event.get('headers', {})["authorization"]
    if not auth_header.startswith('Basic '):
        raise ValueError('Authorization header is not Basic')
    encoded_credentials = auth_header.split(' ', 1)[1]
    decoded_credentials = base64.b64decode(encoded_credentials).decode('utf-8')
    username, password = decoded_credentials.split(':', 1)
    return username, password