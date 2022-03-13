module "securitylib" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "sglib"
  vpc_id      = module.libvpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2lib" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "lib-instance"

  ami                    = "ami-0359b3157f016ae46"
  count                  = "2"
  instance_type          = "t3.micro"
  key_name               = "liba"
  vpc_security_group_ids = [module.securitylib.security_group_id]
  subnet_id              = element(module.libvpc.public_subnets, 0)
  associate_public_ip_address = true
  user_data = "${file("ec2.sh")}"
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = 10

    }
  ]
  tags = {
    Terraform   = "true"
  }
}