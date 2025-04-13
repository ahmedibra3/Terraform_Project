resource "aws_eip" "NAT-EIP" {
    tags = {
      Name = var.EIP
    }

}

resource "aws_nat_gateway" "NAT_Gateway" {
  allocation_id = aws_eip.NAT-EIP.id
  subnet_id     = var.SubNet-ID
  tags = {
    Name = var.NAT-Name
  }
}
