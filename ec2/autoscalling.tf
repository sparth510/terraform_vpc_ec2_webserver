## Creating Launch Configuration
resource "aws_launch_configuration" "autoscale" {
  image_id        = data.aws_ami.ami.id
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.instance_sg.id}"]
  # key_name               = var.key_name
  user_data = <<EOF
          #! /bin/bash
          sudo yum update -y
          sudo yum install -y httpd.x86_64
          sudo systemctl start httpd
          sudo systemctl enable httpd
          echo "HEllo Word form" >  /var/www/html/index.html
          "mkfs -t ext4 /dev/sda2\n",
          "echo \"/dev/sda2 /var/log ext4 defaults,nofail 0 2\" >> /etc/fstab\n",
          "mount -a\n"
            EOF
  ebs_block_device {
    device_name           = "/dev/sda2"
    volume_type           = "gp2"
    volume_size           = "10"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_attachment" "autoscaling-web-group" {
  depends_on             = [aws_autoscaling_group.autoscaling-web-group, aws_lb.web]
  autoscaling_group_name = aws_autoscaling_group.autoscaling-web-group.id
  alb_target_group_arn   = aws_lb_target_group.web.arn
}