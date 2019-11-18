# Provider
variable "availability_zone_name" {
  type    = "string"
  default = "eu-west-1"
  description = "AWS region"
}

# Subnets
variable "bastion_public_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
  description = "The additional IPv4 CIDR block to associate with the public subnet."
}

variable "bastion_private_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
  description = "The additional IPv4 CIDR block to associate with the private subnet."
}

variable "bastion_cluster_name" {
  type    = "string"
  default = "bastion-cluster"
}

# Private security group custom ingress and egress
variable "security_group_ingress_1_from_port" {
  type    = "string"
  description = "Private security group ingress from_port"
}

variable "security_group_ingress_1_to_port" {
  type    = "string"
  description = "Private security group ingress to_port"
}

variable "security_group_ingress_1_protocol" {
  type    = "string"
  default = "tcp"
  description = "Private security group ingress protocol"
}