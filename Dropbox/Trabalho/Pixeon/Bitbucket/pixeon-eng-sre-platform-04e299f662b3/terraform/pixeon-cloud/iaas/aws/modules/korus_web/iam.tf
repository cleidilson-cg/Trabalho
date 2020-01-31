# Korus Web Server

## IAM EC2 policy + role + profile

# IAM role policy
resource "aws_iam_role_policy" "korus_web_server" {
  name = "${var.name}-server"
  role = "${aws_iam_role.korus_web_server.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect":"Allow",
        "Action":[
          "ec2:Describe*"
        ],
        "Resource":"*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:ListBucket"
        ],
        "Resource": [
            "arn:aws:s3:::pixeon-cloud-artifacts"
        ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
        ],
        "Resource": [
            "arn:aws:s3:::pixeon-cloud-artifacts/*"
        ]
    }
    
  ]
}
EOF
}

# IAM role
resource "aws_iam_role" "korus_web_server" {
  name = "${var.name}-server"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM instance profile
resource "aws_iam_instance_profile" "korus_web_server" {
  name = "${var.name}-server"
  role = "${aws_iam_role.korus_web_server.name}"
}

# Korus Hosts

## IAM EC2 policy + role + profile

# IAM role policy
resource "aws_iam_role_policy" "korus_web_hosts" {
  name = "${var.name}-hosts"
  role = "${aws_iam_role.korus_web_hosts.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect":"Allow",
        "Action":[
          "ec2:Describe*"
        ],
        "Resource":"*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:ListBucket"
        ],
        "Resource": [
            "arn:aws:s3:::pixeon-cloud-artifacts"
        ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
        ],
        "Resource": [
            "arn:aws:s3:::pixeon-cloud-artifacts/*"
        ]
    }
  ]
}
EOF
}

# IAM role
resource "aws_iam_role" "korus_web_hosts" {
  name = "${var.name}-hosts"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM instance profile
resource "aws_iam_instance_profile" "korus_web_hosts" {
  name = "${var.name}-hosts"
  role = "${aws_iam_role.korus_web_hosts.name}"
}
