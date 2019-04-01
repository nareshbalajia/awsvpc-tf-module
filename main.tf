# VPC Main resource

resource "aws_vpc" "primary_vpc" {
  cidr_block           = "${var.cidr_range}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
}

# VPC Public subnets
resource "aws_subnet" "public_subnets" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.primary_vpc.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags                    = "${merge(var.tags, map("Name", format("%s-public-subnet-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_subnet" "private_subnets" {
  count             = "${length(var.private_subnets)}"
  vpc_id            = "${aws_vpc.primary_vpc.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags              = "${merge(var.tags, map("Name", format("%s-private-subnet-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
}

# Route tables
resource "aws_route_table" "public_rt" {
  vpc_id           = "${aws_vpc.primary_vpc.id}"
  tags             = "${merge(var.tags, map("Name", format("%s-route-table-public", var.name)))}"
}

resource "aws_route_table" "private_rt" {
  vpc_id           = "${aws_vpc.primary_vpc.id}"
  count            = "${length(var.private_subnets)}"
  tags             = "${merge(var.tags, map("Name", format("%s-route-table-private-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
}

# Route table entries
resource "aws_route" "to_public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route" "to_private_nat_gateway" {
  route_table_id         = "${element(aws_route_table.private_rt.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.private_nat_gw.id}"
  count                  = "${length(var.private_subnets)}"
}

# Route table association
resource "aws_route_table_association" "private_rt_association" {
  count             = "${length(var.private_subnets)}"
  subnet_id         = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id    = "${element(aws_route_table.private_rt.*.id, count.index)}"
}

resource "aws_route_table_association" "public_rt_association" {
  count             = "${length(var.public_subnets)}"
  subnet_id         = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id    = "${aws_route.public_rt.id}"
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  tags   = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

# EIP For NATGW
resource "aws_eip" "private_nat_eip" {
  vpc   = true
}

# NAT Gateway
resource "aws_nat_gateway" "private_nat_gw" {
  allocation_id = "${aws_eip.private_nat_eip.id}"
  subnet_id     = "${aws_subnet.public_subnets.0.id}"
  depends_on    = ["aws_internet_gateway.main"]
}

# Cloudwatch log group
resource "aws_cloudwatch_log_group" "flow_log_group" {
  name = "/aws/flowlog/${var.name}-flow-log-group"
}

# VPC Flow log
resource "aws_flow_log" "vpc_flow_log" {
  log_group_name = "${aws_cloudwatch_log_group.flow_log_group.name}"
  iam_role_arn   = "${aws_iam_role.vpc_flow_log_role.arn}"
  vpc_id         = "${aws_vpc.primary_vpc.id}"
  traffic_type   = "ALL"
}
