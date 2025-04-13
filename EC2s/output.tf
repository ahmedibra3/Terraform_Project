output "EC2-IP" {
  value = aws_instance.Ec2.public_ip
}