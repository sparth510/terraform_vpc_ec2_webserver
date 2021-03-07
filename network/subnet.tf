## public subnet
resource "aws_subnet" "public_subnet" {
  depends_on = [aws_vpc.my_vpc]
  # VPC in which subnet has to be created!
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.subnets_cidr_public, count.index)
  count                   = length(var.subnets_cidr_public)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

output "subnetpublic" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}


## privare subnet
resource "aws_subnet" "private_subnet" {
  depends_on = [aws_vpc.my_vpc]
  # VPC in which subnet has to be created!
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.subnets_cidr_private, count.index)
  count             = length(var.subnets_cidr_private)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
output "subnetprivate" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}
