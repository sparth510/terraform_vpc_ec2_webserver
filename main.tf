module "ec2" {
  source = "./ec2"

}
output "AWS_LB" {
  value = module.ec2.lb_address
}