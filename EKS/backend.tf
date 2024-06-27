terraform {
  backend "s3" {
    bucket = "vpcdata"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"

  }
}
