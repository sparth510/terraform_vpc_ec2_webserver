##public route table
resource "aws_route_table" "public" {
  depends_on = [aws_internet_gateway.ig, aws_vpc.my_vpc]
  vpc_id     = aws_vpc.my_vpc.id
  # add route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

}
## private route table
resource "aws_route_table" "private" {
  depends_on = [aws_internet_gateway.ig, aws_vpc.my_vpc]
  vpc_id     = aws_vpc.my_vpc.id
  # add route
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
}
## route table associations
resource "aws_route_table_association" "public" {
  count          = length(var.subnets_cidr_public)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  count          = length(var.subnets_cidr_private)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private.id
}