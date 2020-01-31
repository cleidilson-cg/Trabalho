terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/aws/test/aws-iaas-test.tfstate"
    region = "us-east-1"
  }
}
