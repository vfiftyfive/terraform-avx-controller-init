provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "/Users/nicolasvermande/.aws/credentials"
  profile                 = var.aws_profile
}
