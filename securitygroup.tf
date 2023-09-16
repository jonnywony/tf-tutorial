locals {
  db_instance   = "10.0.32.50/32"
  inbound_ports = [80, 443]
  outbound_rules = [{
    port        = 443,
    cidr_blocks = [var.vpc-cidr]
    }, {
    port        = 1433,
    cidr_blocks = [local.db_instance]
  }]
}

# Security Groups
resource "aws_security_group" "sg-webserver" {
  vpc_id      = aws_vpc.vpc.id
  name        = "webserver"
  description = "Security Group for Web Servers"
  dynamic "ingress" {
    for_each = local.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = local.outbound_rules
    content {
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = "tcp"
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}