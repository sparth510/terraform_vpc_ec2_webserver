data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_security_group" "load_balancer_sg" {
  vpc_id      = module.network.vpc
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LB_SG"
  }
}

## sg for instance
resource "aws_security_group" "instance_sg" {
  depends_on  = [aws_security_group.load_balancer_sg]
  vpc_id      = module.network.vpc
  name        = "instence"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance-sg"
  }
}

resource "aws_lb" "web" {
  depends_on         = [module.network.internetgateway]
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.load_balancer_sg.id}"]
  subnets            = element(module.network.subnetpublic.*, 1)
  enable_http2       = false


  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc
  health_check {
    healthy_threshold   = 2
    interval            = 10
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

## autoscalling group
resource "aws_autoscaling_group" "autoscaling-web-group" {
  launch_configuration = aws_launch_configuration.autoscale.id
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  health_check_type   = "ELB"
  vpc_zone_identifier = element(module.network.subnetprivate.*, 1)
}

module "network" {
  source = "../network"
}
resource "time_sleep" "wait_120_seconds" {
  create_duration = "120s"
}

output "lb_address" {
  value = aws_lb.web.dns_name
}