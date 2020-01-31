terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/azure/dev/azure-iaas-dev.tfstate"
    region = "us-east-1"
  }
}
