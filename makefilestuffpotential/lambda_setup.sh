
docker-compose down
docker-compose up -d
export AWS_ENDPOINT_URL=http://localhost:4566
pipenv shell
rm -rf testingPackage/
mkdir testingPackage/
cp main.py testingPackage/
pipenv run pip freeze > testingPackage/requirements.txt
pip install -r testingPackage/requirements.txt -t testingPackage/
cd testingPackage/ && zip ../testingPackage.zip ./* && cd ..

aws dynamodb create-table \
    --table-name MyTable \
    --attribute-definitions AttributeName=id,AttributeType=S \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb put-item \
    --table-name MyTable \
    --item '{"id": {"S": "example_id_cli"}, "data": {"S": "example_data_cli_fhekhfjkwhfjwhkfjwhkjfhjkwfhjkwhjkfhwkjhfwkjhfkjh"}}'


aws lambda delete-function --function-name MyDynamoDBFunction

aws lambda create-function \
    --function-name MyDynamoDBFunction \
    --runtime python3.8 \
    --handler main.lambda_handler \
    --role arn:aws:iam::012345678901:role/execution_role \
    --zip-file fileb://testingPackage.zip 

sleep 2
aws lambda invoke --function-name MyDynamoDBFunction output.txt
