resource "aws_security_group" "Sec_Group" {
  name        = var.SG-Name
  vpc_id      = var.VPC-ID

  tags = {
    Name = var.SG-Name
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_HTTPs" {
  security_group_id = aws_security_group.Sec_Group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_HTTP" {
  security_group_id = aws_security_group.Sec_Group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.Sec_Group.id
  cidr_ipv4         = var.SSH-IP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.Sec_Group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
