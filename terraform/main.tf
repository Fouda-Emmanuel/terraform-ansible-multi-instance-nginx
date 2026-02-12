provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "webs_sg" {
  name        = "webs-sg"
  description = "webs-sg for both ec2s"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "webs-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.webs_sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "143.105.152.68/32"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.webs_sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.webs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_key_pair" "web_keypair" {
  key_name   = "web-key-pair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "web" {
for_each = toset(var.instance_names)
ami          = var.ami_id
instance_type = var.instance_type
key_name = aws_key_pair.web_keypair.key_name
vpc_security_group_ids = [aws_security_group.webs_sg.id]


tags = {
  Name = "${each.key}"
}
}