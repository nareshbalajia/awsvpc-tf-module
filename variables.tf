# Tagging
variable "name" {
  description = "Name tag"
}

variable "region" {
  description = "AWS Region"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = "map"
}

# VPC
variable "cidr_range" {
  description = "(Required) The CIDR block for the VPC"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type        = "list"
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = "list"
}


variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = false
}
