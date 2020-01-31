terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/azure/prod/azure-iaas-prod.tfstate"
    region = "us-east-1"
  }
}
