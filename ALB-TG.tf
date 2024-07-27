
resource "aws_lb" "WebALB" {
  name               = "Alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups=[aws_security_group.allow_HTTP.id]
  subnets=[aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Environment = "production"
  }
}

# Target Group - Instance Target Group

resource "aws_lb_target_group" "WebTG" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.mhnd-vpc.id
}

# ALB Listener - Forward Actions


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.WebALB.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebTG.arn
  }
}

# Instance attachment to a Target Group

resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.WebTG.arn
  target_id        = aws_instance.terraform-web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.WebTG.arn
  target_id        = aws_instance.terraform-web2.id
  port             = 80
}
