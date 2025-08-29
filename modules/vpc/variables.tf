# modules/vpc/variables.tf
variable "name" { type = string }
variable "cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "enable_dns_support" { type = bool }
variable "enable_dns_hostnames" { type = bool }
variable "enable_nat_gateway" { type = bool }
variable "single_nat_gateway" { type = bool }
variable "tags" { type = map(string) }
