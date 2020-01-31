import boto3
from botocore.client import Config

# Get the service client with sigv4 configured
s3 = boto3.client('s3', config=Config(signature_version='s3v4'))

# Generate the URL to get 'key-name' from 'bucket-name'
# URL expires in 604800 seconds (seven days)
url = s3.generate_presigned_url(
    ClientMethod='get_object',
    Params={
        'Bucket': 'backup-pleres-db',
        'Key': 'area-transferencia/CLOUD-704/*'
    },
    ExpiresIn=604800
)

print(url)