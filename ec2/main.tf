variable "instance_ami" {
  description = "ec2 instance ami."
  type        = string
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "ec2 instance name"
  type        = string
}

resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
