module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "application" {
  source              = "./modules/application"
  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id
  security_group_id   = module.security.web_sg_id
}

module "load_balancer" {
  source = "./modules/load_balancer"
  security_group_id = module.security.web_sg_id
  subnet_ids        = module.network.public_subnet_ids 
  vpc_id            = module.network.vpc_id
  instance_1_id     = module.application.instance_1_id
  instance_2_id     = module.application.instance_2_id
}

module "internet_gateway" {
  source            = "./modules/internet_gateway"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}
