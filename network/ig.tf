#creare InternetGetway
resource "aws_internet_gateway" "ig" {
  depends_on = [aws_vpc.my_vpc, aws_subnet.public_subnet]
  # VPC in which it has to be created!
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "IG-Public-&-Private-VPC"
  }
}