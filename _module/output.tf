output "transit_gateway" {
  value = "${aws_ec2_transit_gateway.tf-tgw.id}"
}