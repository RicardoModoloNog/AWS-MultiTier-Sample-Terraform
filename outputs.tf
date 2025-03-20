output "vpc_id" {
  value = module.network.vpc_id
}

output "load_balancer_dns" {
  value = module.load_balancer.load_balancer_dns
}
