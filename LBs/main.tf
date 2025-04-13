resource "aws_lb_target_group" "Target-Group" {
  name     = var.Target-Group-Name  
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.VPC-ID 
}
resource "aws_lb_listener" "Listener" {
  load_balancer_arn = aws_lb.Load-Balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Target-Group.arn
  }
}
resource "aws_lb" "Load-Balancer" {
  name               = var.LB-Name
  internal           = var.Internal-LB 
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = var.LB-Sec-Group
  subnets            = var.SubNet-ID
}
