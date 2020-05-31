# Transit Gateway
resource "aws_ec2_transit_gateway" "tf-tgw" {
  description                     = "Transit Gateway for TF VPCs"
  amazon_side_asn                 = "${var.amazon_side_asn}"
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"

  tags = {
    Name        = "${var.env}.tgw"
    Provisioner = "${var.provisioner}"
  }
}

# Transit Gateway Attachment(s)
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_tgwa" {
  transit_gateway_id = "${aws_ec2_transit_gateway.tf-tgw.id}"
  vpc_id             = "${var.vpc1.id}"
  dns_support        = "enable"

  subnet_ids = "${var.vpc1.subnet_ids}"

  tags = {
    Name        = "${var.env}.tgwa.vpc1"
    Provisioner = "${var.provisioner}"
  }
}


resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2_tgwa" {
  transit_gateway_id = "${aws_ec2_transit_gateway.tf-tgw.id}"
  vpc_id             = "${var.vpc2.id}"
  dns_support        = "enable"

  subnet_ids = "${var.vpc2.subnet_ids}"

  tags = {
    Name        = "${var.env}.tgwa.vpc2"
    Provisioner = "${var.provisioner}"
  }
}

# Adding VPCs' Route for Transit Gateway
resource "aws_route" "vpc1-tgw-route" {
  transit_gateway_id     = "${aws_ec2_transit_gateway.tf-tgw.id}"
  route_table_id         = "${var.vpc1.route_id}"
  destination_cidr_block = "${var.tgw_destination_cidr_block}"
}

resource "aws_route" "vpc2-tgw-route" {
  transit_gateway_id     = "${aws_ec2_transit_gateway.tf-tgw.id}"
  route_table_id         = "${var.vpc2.route_id}"
  destination_cidr_block = "${var.tgw_destination_cidr_block}"
  
}