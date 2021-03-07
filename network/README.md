# NETWOEK
- in this module we are create  **VPC**,**public_subnet**and **private_subnet**
- for change the cidr block open variable.tf
- in network module we are create 3 public and 3 private subnet in the mumbai region
- if you change the region that please change [here](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/provider.tf#L2) and chang [availability zone](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/d44449f5ebd90f282a8d6c701ab92e811797935a/network/variable.tf#L10) 
## how to create resource , please check this file
- [VPC](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/network/vpc.tf)
- [Internet Gateway](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/network/ig.tf)
- [Nat Gateway](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/network/netig.tf)
- [Subnet](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/network/subnet.tf)
- [route_table](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/network/routetable.tf)