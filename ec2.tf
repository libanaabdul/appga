module "securitylib" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "sglib"
  vpc_id      = module.libvpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
}

module "ec2lib" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "lib-instance"

  ami                    = "ami-0359b3157f016ae46"
  count                  = "2"
  instance_type          = "t3.micro"
  key_name               = "${module.keyliba.key_pair_key_name}"
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

module "keyliba" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "liba"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdDaZ+mcj/0OKLNHBjFWEjUdixkPhUXOlxNrkcQm68pwrxzN7PRtb17EIkxFe1mIhD1vdeifVCLPJL6IKKggLe97uGHztbNnDYDSff/ktWpYsK9SOE1wn4auP2UH2ToCVPBmNDYIwg/i1kFuVrzYQ7SKVb/WL2lLyacZtrYNiazcba1OdR333QoTWvt/1m3WBrcR4oWz17uk+PlT8Uy9XCisWkb3IGBQ2uTOnpA8DknG2W98a29myVdY2OWOS0ShandNfwexucJCWAKSlYICQgp8nrQxpIKpLFpQ6hDL0nrF1PqRvWAENSJFEipMwDJYiBtjKzO2hUyCkbg1z3yf8/"

  tags = {
    External = "yes"
  }
}
