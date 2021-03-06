## Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  # Enabling automatic hostname assigning
  enable_dns_hostnames = true
}
output "vpc" {
  value = aws_vpc.my_vpc.id
}


