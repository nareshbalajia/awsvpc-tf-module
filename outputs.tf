# TF output resources
output "vpc_id" {
  value = "${aws_vpc.primary_vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.primary_vpc.cidr_block}"
}

output "private_subnets_ids" {
  value = ["${aws_subnet.public_subnets.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.public_rt.*.id}"]
}
