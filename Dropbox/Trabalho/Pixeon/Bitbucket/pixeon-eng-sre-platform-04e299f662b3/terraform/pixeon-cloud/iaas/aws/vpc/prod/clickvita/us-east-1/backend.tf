terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/aws/prod/aws-iaas-clickvita-prod-us.tfstate"
    region = "us-east-1"
  }
}