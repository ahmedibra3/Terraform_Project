data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
resource "aws_instance" "Ec2" {
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = var.instance-type
  subnet_id              = var.Subnet-ID
  key_name               = "key"
  vpc_security_group_ids = [var.Security-Group-ID]
  tags = {
    Name = var.instance-name
  }
  user_data = var.user-data
}
resource "null_resource" "Remote-Exec" {
  # This resource is used to run remote commands on the EC2 instance
  count = var.Enable-Remote ? 1 : 0

  provisioner "remote-exec" {
    inline = var.Remote-Exec
  }
  connection {
    type        = "ssh"
    host        = aws_instance.Ec2.public_ip
    user        = "ec2-user"
    private_key = file("~/key.pem")
  }
}

resource "aws_lb_target_group_attachment" "EC2-Target" {
  target_group_arn = var.Target-Group-arn
  target_id        = aws_instance.Ec2.id
  port             = 80
}
