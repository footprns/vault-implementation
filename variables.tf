variable "shared_vpc_cidr" {
  default = "10.52.0.0/16"
}
variable "gke_master_cidr" {
  default = "10.55.0.0/28" # it must /28
}

variable "cluster_ipv4_cidr" {
  default = "10.54.0.0/21" # it need /21
}

variable "services_ipv4_cidr" {
  default = "10.53.2.0/24" # 20 pods/node * 12 =240
}

