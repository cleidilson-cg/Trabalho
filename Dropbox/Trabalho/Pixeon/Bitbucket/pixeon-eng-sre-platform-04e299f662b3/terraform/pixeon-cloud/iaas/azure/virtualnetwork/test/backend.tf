terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/azure/test/azure-iaas-test.tfstate"
    region = "us-east-1"
  }
}
