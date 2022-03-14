output "libvpc" {
  value = {
    vpc_id          = module.libvpc.vpc_id,
    public_subnets  = module.libvpc.public_subnets,
    private_subnets = module.libvpc.private_subnets,
  }
}

output "ec2lib" {
value = {
  instance_id  = module.ec2lib[1].id
  ip           = module.ec2lib[1].public_ip
  }  
}

output "key_pair_key_name" {
  description = "The key pair name."
  value       = module.keyliba.key_pair_key_name
}

output "key_pair_key_pair_id" {
  description = "The key pair ID."
  value       = module.keyliba.key_pair_key_pair_id
}

output "key_pair_fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = module.keyliba.key_pair_fingerprint
}