resource "aws_subnet" "project_subnet" {
    cidr_block = var.CIDR_Subnet
    vpc_id = var.VPC_ID
    map_public_ip_on_launch = var.Public_or_Private
    availability_zone = var.Public_or_Private ? var.Availability_Zone[0] : var.Availability_Zone[1]
    tags = {
    Name = var.Subnet_Name
  }
}


resource "aws_route_table_association" "Sub-RT" {
  subnet_id      = aws_subnet.project_subnet.id
  route_table_id = var.RT-ID
}
