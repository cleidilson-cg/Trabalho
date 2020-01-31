terraform {
  backend "s3" {
    bucket = "eng-sre-platform"
    key    = "terraform-states/pixeon-cloud/korus/dev/rds.dev01.tfstate"
    region = "us-east-1"
  }
}
