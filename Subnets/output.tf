output "Subnet-ID" {
    value = aws_subnet.project_subnet.id
}
output "Name" {
    value = aws_subnet.project_subnet.tags["Name"]
}