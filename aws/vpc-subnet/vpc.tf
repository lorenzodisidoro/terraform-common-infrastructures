# Create VPC and provide it an IP range in order to create our network

resource "aws_vpc" "bastion_vpc" {
 cidr_block = "${var.bastion_public_cidr}"
 enable_dns_hostnames = true
 enable_dns_support = true

 tags = {
  Application = "${var.bastion_cluster_name}" 
  Environment = "${terraform.workspace}"
  Name = "vpc-bastion-cluster"
 }
}

resource "aws_internet_gateway" "bastion_gateway" {
 vpc_id = "${aws_vpc.bastion_vpc.id}"
 tags = {
  Application = "${var.bastion_cluster_name}"
  Environment = "${terraform.workspace}"
  Name = "bastion-internet-gateway"
 }
}

resource "aws_eip" "nat_ip" {
 vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
 allocation_id = "${aws_eip.nat_ip.id}"
 subnet_id = "${aws_subnet.bastion_public_subnet.id}"
 depends_on = ["aws_internet_gateway.bastion_gateway"]
}