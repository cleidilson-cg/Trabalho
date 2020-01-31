terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/korus/alliar/prod/prod001.tfstate"
    region = "us-east-1"
    profile = "pixeon"
  }
}
