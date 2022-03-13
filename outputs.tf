output "libvpc" {
  value = {
    vpc_id          = module.libvpc.vpc_id,
    public_subnets  = module.libvpc.public_subnets,
    private_subnets = module.libvpc.private_subnets,
  }
}
