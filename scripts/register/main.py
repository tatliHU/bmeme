import json
import boto3
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        username = body['username']
        password = body['password']
    except (KeyError, TypeError, json.JSONDecodeError) as e:
        return {
            'statusCode': 400,
            'body': 'Invalid input'
        }
    if user_exist(username):
        return {
            'statusCode': 400,
            'body': 'User already exists'
        }
    write_db(username, password)
    return {
        'statusCode': 201,
        'body': 'User created'
    }

def write_db(username, password):
    db = boto3.resource('dynamodb')
    table = db.Table('user')
    try:
        table.put_item(
            Item={
                'UserName': username,
                'Password': password,
                'EmailVerified': False,
                'Score': 0
            }
        )
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': 'DBError: Could not register user'
        }

def user_exist(username):
    try:
        db = boto3.resource('dynamodb')
        table = db.Table('user')
        response = table.get_item(
            Key={'UserName': username}
        )
        if 'Item' in response:
            return True
        return False
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': 'DBError: Could not check if user exists'
        }