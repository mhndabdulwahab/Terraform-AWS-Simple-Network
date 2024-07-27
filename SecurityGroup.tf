########################################################################################
#                   Allow SSH & HTTP                                                   #
########################################################################################

resource "aws_security_group" "allow_SSH_HTTP" {
  name        = "allow_SSH_HTTP"
  description = "Allow HTTP and SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.mhnd-vpc.id

  tags = {
    Name = "webSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_HTTP" {
  security_group_id = aws_security_group.allow_SSH_HTTP.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_SSH" {
  security_group_id = aws_security_group.allow_SSH_HTTP.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_Web" {
  security_group_id = aws_security_group.allow_SSH_HTTP.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

########################################################################################
#                   Allow  HTTP                                                        #
########################################################################################


resource "aws_security_group" "allow_HTTP" {
  name        = "allow_HTTP"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.mhnd-vpc.id

  tags = {
    Name = "ALB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_HTTP_ALB" {
  security_group_id = aws_security_group.allow_HTTP.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ALB" {
  security_group_id = aws_security_group.allow_HTTP.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = aws_security_group.allow_SSH_HTTP.id
#   network_interface_id = aws_instance.mhnd_terraform.primary_network_interface_id
# }

