resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow MYSQL inbound traffic"
  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}


output "aws_security_group_id" {
    value = aws_security_group.allow_mysql.id
}
