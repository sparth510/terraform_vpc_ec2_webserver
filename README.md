# terraform_vpc_ec2_volume_webserver
## prerequisite
- terraform 0.12 versio requiment
- aws cli configure requiment

# How To Use
- first command install plugin of terraform
```
terraform init
```
- second check the plan
```
terraform plan
```
- after check plan we are apply our terraform script

```
terraform apply
```
## what modules use in this script
- in script we are use two module use 
    - first module is **network** : for more understand please follow this [link](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/network/README.md)
    - second module is **ec2** : for more understand please follow this [link](https://github.com/sparth510/terraform_vpc_ec2_webserver/blob/main/ec2/README.md)

