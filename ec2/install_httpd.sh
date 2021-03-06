#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd
sudo systemctl enable httpd
echo "HEllo Word form" >  /var/www/html/index.htm
            