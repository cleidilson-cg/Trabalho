config = {

    # Optional settings are commented out

    # set 'dry_run' to any value to disable autosnap from actually taking/deleting snapshots
    #'dry_run': 'true',

    # AWS credentials (remove if using an EC2 instance with an IAM role)
    #'aws_access_key': 'xxxxxxxx',
    #'aws_secret_key': 'xxxxxxxxxxxx',

    # EC2 info about your server's region
    'ec2_region_name': 'sa-east-1',
    'ec2_region_endpoint': 'ec2.sa-east-1.amazonaws.com',

    # Name of the intance tag autosnap should look for
    'tag_name': 'autosnap',

    # Number of snapshots to keep
    'keep_snapshots': 4,

    # Path where you want to save the log
    'log_file': '/var/log/autosnap.log',

    # ARN of the SNS topic (optional)
    'sns_arn': 'arn:aws:sns:us-east-1:708426649097:sre',

    # Proxy config (optional)
    #'proxyHost': '10.100.x.y',
    #'proxyPort': '8080'
}
