terraform {
  backend "s3" {
    bucket = "${var.state_bucket}"
    key = "terraform/backend/vpc-infra/vpc_infra/terraform.tfstate"
    region = "${var.region}"
    encrypt = true
  }
}
