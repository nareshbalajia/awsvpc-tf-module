# TF output resources
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "private_subnets_ids" {
  value = ["${aws_subnet.public_subnets.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private_subnets.*.id}"]
}
