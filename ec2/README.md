## EC2
### In EC2 module we are creating EC2 services 

### Instance
- Instance will be in private subnet
- We are using **amazon linux**,latest ami we are use [data source](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L1)
- We are using **aws_launch_configuration** for creating ec2 instance 
- To change instance type change [here](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/ec2/variable.tf#L10)

## Loadbalancer
- We are creating loadbalancerr in public subnet using terraform resource [aws_lb](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L62) 
 and attaching targate group to loadbalancer using terraform resource [aws_lb_target_group](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L77)
## Autoscaling 

-  We are createing autoscaling using terraform resouce  [aws_autoscaling_group](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/main.tf#L102) 
- For attaching our autoscaling group to application load balancer attachment we are using terraform resource [aws_autoscaling_attachment](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/autoscalling.tf#L29)

## Volume
- Secondery volume attached using terrafrom resource is [aws_launch_configuration](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/autoscalling.tf#L18) and mounting to instance with [user_data](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/e93b5906628f906a64878fa3e89bc7b68abec396/ec2/autoscalling.tf#L14) script