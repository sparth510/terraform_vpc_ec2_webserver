module "ec2" {
  source = "./ec2"

}
output "LB_ADDRESS" {
   value = module.LB_ADDRESS.lb_address
}
