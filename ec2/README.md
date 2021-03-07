## EC2
### In EC2 module we are created EC2 services instance,LB,Autoscalling group,volume

### instance
- for create ec2 instance we are using **aws_launch_configuration**, if you want to add pem file into our server that time add the [pemkey](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/variable.tf#L12) and [uncomment](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/autoscalling.tf#L6)
- for change instance tyrp change [here](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/variable.tf#L10)

## autoscallig 
