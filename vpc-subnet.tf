
resource "aws_vpc" "mhnd-vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "mhnd-vpc"
  }
}

########################################################################################
#                   Private Subnet                                                     #
########################################################################################
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.mhnd-vpc.id
  cidr_block = "10.0.100.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private1"
  }
 #depends_on = [aws_nat_gateway.mhnd-natgw1]
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.mhnd-vpc.id
  cidr_block = "10.0.200.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private2"
  }
 #depends_on = [aws_nat_gateway.mhnd-natgw2]
}

########################################################################################
#                   Public Subnet                                                     #
########################################################################################

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.mhnd-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "public1"
  }
  #depends_on = [aws_internet_gateway.mhnd-gw]
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.mhnd-vpc.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "public2"
  }
  #depends_on = [aws_internet_gateway.mhnd-gw]
}