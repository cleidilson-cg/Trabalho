terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/korus/dev/dev003.tfstate"
    region = "us-east-1"
  }
}
