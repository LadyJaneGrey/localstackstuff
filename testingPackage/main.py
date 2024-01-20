import os
import boto3
from datetime import datetime
def lambda_handler(event = None, context = None):
    # return os.environ['AWS_ENDPOINT_URL']
    dynamodb = boto3.resource('dynamodb', endpoint_url=os.environ['AWS_ENDPOINT_URL'])
    table_name = 'MyTable'  # Replace with your DynamoDB table name

    table = dynamodb.Table(table_name)

    # Example: Put an item into DynamoDB
    response = table.put_item(
        Item={
            'id': 'example_id_yeetus',
            'data': 'example_data'
        }
    )

    # Example: Query DynamoDB
    response = table.get_item(
        Key={
            'id': 'example_id_cli'
        }
    )
    #
    #  Example: Query DynamoDB
    response_2 = table.get_item(
        Key={
            'id': 'example_id_yeetus'
        }
    )
    return str([response.get('Item', None), response_2.get('Item', None), datetime.now()])
 

