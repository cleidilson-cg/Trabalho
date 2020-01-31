terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/korus/pixeon/dev/dev001.tfstate"
    region = "us-east-1"
  }
}
