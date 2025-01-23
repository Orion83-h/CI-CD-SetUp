# This security group is used to allow traffic to the remote servers. 
# The security group allows inbound traffic from the user's IP address and outbound traffic to all IP addresses.
# By configuring the security group to allow traffic from the user's IP address only is best practice.
resource "aws_security_group" "demo" {
  name        = var.sec_grp_name
  description = "Secure inbound traffic into remote servers"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_rule
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.my_ip_address
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Rhino-SG"
  }
}