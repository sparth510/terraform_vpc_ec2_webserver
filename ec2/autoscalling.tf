## Creating Launch Configuration
resource "aws_launch_configuration" "example" {
  image_id        = data.aws_ami.ami.id
  instance_type   = "t2.medium"
  security_groups = ["${aws_security_group.instance_sg.id}"]
  # key_name               = "${var.key_name}"
  user_data = <<EOF
          #! /bin/bash
          sudo yum update -y
          sudo yum install -y httpd.x86_64
          sudo systemctl start httpd
          sudo systemctl enable httpd
          echo "HEllo Word form" >  /var/www/html/index.htm
            EOF
  lifecycle {
    create_before_destroy = true
  }
}
# resource "aws_launch_template" "lunch_templete" {
#   name_prefix   = "web_instance"
#   image_id      = data.aws_ami.ami.id
#   instance_type = "t2.medium"
#   vpc_security_group_ids = ["${aws_security_group.load_balancer_sg.id}"]
#   user_data  = "./install_httpd.sh"

# }

## auctoscalling group policy
# resource "aws_autoscaling_policy" "autoscaling-policy" {
#   name               = "autoscallng-plicy"
#   scaling_adjustment = 1
#   adjustment_type    = "ChangeInCapacity"
#   cooldown           = 300
#   #min_adjustment_magnitude = 70
#   autoscaling_group_name = aws_autoscaling_group.autoscaling-web-group.name
# }

resource "aws_autoscaling_attachment" "autoscaling-web-group" {
  depends_on             = [aws_autoscaling_group.autoscaling-web-group, aws_lb.web]
  autoscaling_group_name = aws_autoscaling_group.autoscaling-web-group.id
  alb_target_group_arn   = aws_lb_target_group.web.arn
}