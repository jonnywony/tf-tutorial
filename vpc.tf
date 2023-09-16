variable "vpc-cidr" {
  default = "10.0.0.0/16"
}
# Subnets variable
variable "vpc-subnets" {
  default = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
}

resource "aws_subnet" "main-subnet" {
  for_each   = toset(var.vpc-subnets)
  cidr_block = each.value
  vpc_id     = aws_vpc.vpc.id
}