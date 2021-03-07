## EC2
### In EC2 module we are creating EC2 services 

### Instance
- instence is create in private subenet
- AMI we are use amazon machine image . for latest ami we are use [data source](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L1)
- for create ec2 instance we are using **aws_launch_configuration**, if you want to add pem file into our server that time add the [pemkey](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/variable.tf#L12) and [uncomment](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/autoscalling.tf#L6)
- for change instance tyrp change [here](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/variable.tf#L10)

## Loadbalancer
- create loadblaencer , used resource [aws_lb](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L62) loadbalancer is is creating on public subnet
- targate group we are use resource [aws_lb_target_group](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L77)
## Autoscaling 

- for autoscaling , resouce name is [aws_autoscaling_group](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L102) and if you are change min,max and desired size of [instacne](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L102s) change the aws_autoscaling_group
- for attach our autoscaling group to application load balancer attachment we are use resource [aws_autoscaling_attachment](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/autoscalling.tf#L29)

## voume 
- secondery volume add use resource is [aws_launch_configuration](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/autoscalling.tf#L18) and mount for instance we are use [user_data](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/autoscalling.tf#L14)