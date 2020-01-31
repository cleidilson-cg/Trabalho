terraform {
  backend "s3" {
    bucket  = "eng-sre-platform"
    key     = "terraform-states/pixeon-cloud/load-balancers/nlb-prod.tfstate"
    region  = "us-east-1"
    profile = "pixeon-account"
  }
}
