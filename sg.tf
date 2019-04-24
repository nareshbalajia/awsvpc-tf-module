# Application Security group

resource "aws_security_group" "app_db" {
  name = "${var.name}-app-security-group"
  description = "Security Group for Application"

  vpc_id = "${aws_vpc.primary_vpc.id}"

  ingress {
    ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }
}
