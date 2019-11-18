# AWS Doc: A security group acts as a virtual firewall for your instance to control inbound and outbound traffic. When you launch an instance in a VPC, you can assign up to five security groups to the instance. 
# AWS Doc: Security groups act at the instance level, not the subnet level.

# create public security group attached to the public subnet 
# where is allowing only traffic to the ssh protocol (on port 22)
# using ip range 0.0.0.0/0 because allowing traffic from the internet
resource "aws_security_group" "bastion_public_security_group" {
  description = "Enable HTTP"
  vpc_id      = "${aws_vpc.bastion_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Application = "${var.bastion_cluster_name}"
    Environment = "${terraform.workspace}"
    Name        = "${var.bastion_cluster_name}-security-group"
  }
}

# create private security group and allowing traffic only to the ssh protocol and to the custom service protocol (eg. service running on EC2 instance) which runs on ports 22 and 'security_group_ingress_1_from_port',
# and allowing outbound communications to internet from private security group
resource "aws_security_group" "bastion_private_security_group" {
  description = "Enable HTTP"
  vpc_id      = "${aws_vpc.bastion_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.bastion_public_cidr}"]
  }

  # custom ingress
  ingress {
    from_port   = "${var.security_group_ingress_1_from_port}"
    to_port     = "${var.security_group_ingress_1_to_port}"
    protocol    = "${var.security_group_ingress_1_protocol}"
    cidr_blocks = ["${var.bastion_public_cidr}"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.bastion_public_cidr}"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.bastion_public_cidr}"]
  }

  # custom egress
  egress {
    from_port   = "${var.security_group_ingress_1_from_port}"
    to_port     = "${var.security_group_ingress_1_to_port}"
    protocol    = "${var.security_group_ingress_1_protocol}"
    cidr_blocks = ["${var.bastion_public_cidr}"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.bastion_public_cidr}"]
  }

  tags = {
    Application = "${var.bastion_cluster_name}"
    Environment = "${terraform.workspace}"
    Name        = "${var.bastion_cluster_name}-private-security-group"
  }
}