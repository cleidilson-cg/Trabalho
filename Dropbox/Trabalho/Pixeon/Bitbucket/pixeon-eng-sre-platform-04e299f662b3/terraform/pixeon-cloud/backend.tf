terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/iaas.tfstate"
    region = "us-east-1"
  }
}
