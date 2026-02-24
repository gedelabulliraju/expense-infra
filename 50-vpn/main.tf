resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("~/.ssh/openvpn.pub")
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.openvpn.key_name
  ami = data.aws_ami.joindevops.id
  name = local.resource_name

  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    var.vpn_tags,
    {
        Name = local.resource_name
    }
  )
}