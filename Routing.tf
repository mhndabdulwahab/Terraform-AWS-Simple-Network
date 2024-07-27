
########################################################################################
#                   Public Routing                                                    #
########################################################################################

resource "aws_route_table" "public1-rt" {
  vpc_id = aws_vpc.mhnd-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mhnd-gw.id
  }

  tags = {
    Name = "publicRountig"
  }
  depends_on = [aws_internet_gateway.mhnd-gw]
}


resource "aws_route_table" "public2-rt" {
  vpc_id = aws_vpc.mhnd-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mhnd-gw.id
  }

  tags = {
    Name = "publicRountig"
  }
  depends_on = [aws_internet_gateway.mhnd-gw]
}

########################################################################################
#                   Public Routing Association                                         #
########################################################################################


resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public1-rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public2-rt.id
}

########################################################################################
#                   Private Routing                                                    #
########################################################################################

resource "aws_route_table" "private1-rt" {
  vpc_id = aws_vpc.mhnd-vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mhnd-natgw1.id
  }
  tags = {
    Name = "PrivateRouting"
  }
  depends_on = [aws_nat_gateway.mhnd-natgw1]
}

resource "aws_route_table" "private2-rt" {
  vpc_id = aws_vpc.mhnd-vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mhnd-natgw2.id
  }
  tags = {
    Name = "PrivateRouting"
  }
  depends_on = [aws_nat_gateway.mhnd-natgw2]
}

########################################################################################
#                   Private Routing Association                                         #
########################################################################################


resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private1-rt.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private2-rt.id
}
########################################################################################