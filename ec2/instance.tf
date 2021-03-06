

## create volume
resource "aws_ebs_volume" "log" {
  #  depends_on        = [aws_instance.web]
  availability_zone = var.az
  size              = var.ebs_size
}

## attach volume 
resource "aws_volume_attachment" "ebs_att" {
  depends_on  = [aws_ebs_volume.log]
  device_name = "/dev/sda2"
  volume_id   = aws_ebs_volume.log.id
  instance_id = aws_instance.web.id
}

## latest aws ami we are use data source
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# create new instance
resource "aws_instance" "web" {
  depends_on      = [aws_security_group.instance_sg]
  ami             = data.aws_ami.ami.id
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.instance_sg.id}"]
  subnet_id       = element(module.network.subnetprivate[0], 1)
  user_data       = <<EOF
          #! /bin/bash
          sudo yum update -y
          sudo yum install -y httpd.x86_64
          sudo systemctl start httpd
          sudo systemctl enable httpd
          echo "HEllo Word form" >  /var/www/html/index.html
    EOF
  tags = {
    Name = "web_instance"
  }
}

##output of instaence

output "instance" {
  value = []
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
  depends_on         = [aws_instance.web]
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
    healthy_threshold = 2
    interval          = 30
    #path                = "/var/www/html/index.html"
    timeout             = 10
    unhealthy_threshold = 2
  }
}

# resource "aws_lb_target_group_attachment" "web_lb_attach" {
#   target_group_arn = aws_lb_target_group.web.arn
#   target_id        = aws_launch_template.lunch_templete.id
#   port             = 80
# }

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

## autoscalling group
resource "aws_autoscaling_group" "autoscaling-web-group" {
  launch_configuration = aws_launch_configuration.example.id
  #capacity_rebalance = true
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  #load_balancers = [aws_lb.web.name]
  health_check_type = "ELB"
  #  availability_zones = ["var.az"]

  vpc_zone_identifier = element(module.network.subnetprivate.*, 1)
  # mixed_instances_policy {
  #   instances_distribution {
  #     on_demand_base_capacity                  = 0
  #     on_demand_percentage_above_base_capacity = 75
  #   }
  #   launch_template {
  #     launch_template_specification {
  #       launch_template_id = aws_launch_template.lunch_templete.id
  #     }

  #     override {
  #       instance_type     = "t2.medium"
  #       weighted_capacity = "1"
  #     }
  #   }
  # }

}

module "network" {
  source = "../network"
}

output "lb_address" {
  value = []
}