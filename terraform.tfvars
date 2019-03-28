# ---------------------------------------------------------------------------------------------------------------------
# Terraform Default variables
# ---------------------------------------------------------------------------------------------------------------------
name = "test-vpc"

tags {
  Environment  = "test"
  BusinessUnit = "Infra"
  CreatedBy    = "terraform-jenkins"
  Region       = "us-east-1"
}

region = "us-east-1"
vpc_cidr = "10.101.0.0/16"
private_subnets = ["10.101.4.0/24", "10.101.5.0/24", "10.101.6.0/24"]
public_subnets = ["10.101.7.0/24", "10.101.8.0/24", "10.101.9.0/24"]
enable_dns_hostnames = true
enable_dns_support = true
map_public_ip_on_launch = false
