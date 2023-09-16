variable "create_ec2" {
  description = "If set to true, it will create ec2"
  type = bool
  default = false
}

resource "aws_instance" "server" {
  count = var.create_ec2 ? 1 : 0

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

}