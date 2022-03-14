module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "alblib"

  load_balancer_type = "application"

  vpc_id             = module.libvpc.vpc_id
  subnets            = module.libvpc.public_subnets
  security_groups    = [module.securitylib.security_group_id]

  target_groups = [
    {
      name_prefix      = "p-lib"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = module.ec2lib[1].id
          port = 80
        },
        {
          target_id = module.ec2lib[1].id
          port = 443
        }
      ]
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-west-2:441304528954:certificate/7c40f721-dea0-4b3f-ba93-08b4b14bb451"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform   = "true"
  }
}