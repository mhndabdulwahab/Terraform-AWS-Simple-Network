
resource "aws_instance" "terraform-web1" {
  ami           = "ami-008ea0202116dbc56"
  instance_type = "t2.micro"
  key_name = "mhndkey"
  subnet_id = aws_subnet.private1.id
  vpc_security_group_ids = [aws_security_group.allow_SSH_HTTP.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f) in public 1 </h1>" > /var/www/html/index.html
              EOF
    tags = {
    Name = "dolfined-instance1"
  }
}

resource "aws_instance" "terraform-web2" {
  ami           = "ami-008ea0202116dbc56"
  instance_type = "t2.micro"
  key_name = "mhndkey"
  subnet_id = aws_subnet.private2.id
  vpc_security_group_ids = [aws_security_group.allow_SSH_HTTP.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f) in public 2 </h1>" > /var/www/html/index.html
              EOF
    tags = {
    Name = "dolfined-instance2"
  }
}

