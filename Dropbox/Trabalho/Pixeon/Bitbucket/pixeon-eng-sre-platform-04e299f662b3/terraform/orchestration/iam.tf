# Rancher Server

## IAM EC2 policy + role + profile

# IAM role policy

resource "aws_iam_role_policy" "rancher_server" {
  name = "rancher-server"
  role = "${aws_iam_role.rancher_server.id}"

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
    }
  ]
}
EOF
}

# IAM role

resource "aws_iam_role" "rancher_server" {
  name = "rancher-server"
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

resource "aws_iam_instance_profile" "rancher_server" {
  name = "rancher-server"
  role = "${aws_iam_role.rancher_server.name}"
}

# Rancher Hosts

## IAM EC2 policy + role + profile

# IAM role policy

resource "aws_iam_role_policy" "rancher_hosts" {
  name = "rancher-hosts"
  role = "${aws_iam_role.rancher_hosts.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect":"Allow",
        "Action":[
          "ec2:Describe*",
          "sqs:ReceiveMessage"
        ],
        "Resource":"*"
    }
  ]
}
EOF
}

# IAM role

resource "aws_iam_role" "rancher_hosts" {
  name = "rancher-hosts"
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

resource "aws_iam_instance_profile" "rancher_hosts" {
  name = "rancher-hosts"
  role = "${aws_iam_role.rancher_hosts.name}"
}
