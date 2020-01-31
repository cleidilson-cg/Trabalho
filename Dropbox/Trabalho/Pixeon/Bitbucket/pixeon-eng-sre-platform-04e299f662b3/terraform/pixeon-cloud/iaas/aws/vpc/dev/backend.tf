terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/aws/dev/aws-iaas-dev.tfstate"
    region = "us-east-1"
  }
}
