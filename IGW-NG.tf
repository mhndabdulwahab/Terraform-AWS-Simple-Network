resource "aws_internet_gateway" "mhnd-gw" {
  vpc_id = aws_vpc.mhnd-vpc.id

  tags = {
    Name = "mhnd-IG"
  }
}

resource "aws_eip" "mhnd-eb1" {
  vpc = true
    tags = {
    Name = "mhnd-EIP"
  }
}

resource "aws_eip" "mhnd-eb2" {
  vpc = true
    tags = {
    Name = "mhnd-EIP"
  }
}

resource "aws_nat_gateway" "mhnd-natgw1" {
  allocation_id = aws_eip.mhnd-eb1.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "MHND GW NAT"
  }
}

resource "aws_nat_gateway" "mhnd-natgw2" {
  allocation_id = aws_eip.mhnd-eb2.id
  subnet_id     = aws_subnet.public2.id

  tags = {
    Name = "MHND GW NAT"
  }
}
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.mhnd-gw]
