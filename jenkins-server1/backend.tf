terraform {
  backend "s3" {
    bucket = "vpcdata"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"

  }
}
