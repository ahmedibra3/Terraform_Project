resource "aws_route_table" "RT" {
  vpc_id = var.VPC-ID
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.IGW-ID !=""? var.IGW-ID : null
    nat_gateway_id = var.NAT-ID !=""? var.NAT-ID : null 
  }
  tags = {
    Name = var.RT_Name
  }
}
