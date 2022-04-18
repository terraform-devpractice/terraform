provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAWLKAUQJ4Z3JGFWM3"
  secret_key = "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"
}
resource "aws_instance" "ec2server" {
  ami = "ami-0851b76e8b1bce90b"
    instance_type = "t2.micro"
    key_name = "raju"
    security_groups = ["rajusecurity group"]
    tags = {
     Name = "raju terrafom server"
   }
}
resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2server.id
  allocation_id = aws_eip.eip.id
}
resource "aws_security_group" "rajunewsgforeipassociation" {
  name = "rajunewsgforeipassociation"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${aws_eip.eip.public_ip}/32"]
  }

}
