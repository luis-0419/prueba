variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "snet_vm_name" {
  type = string
}

# variable "snet_vm_address_prefix" {
#   type = list(string)
#   default = ["192.168.10.0/24"]
# }

# variable "agent_count" {
#   type = number
# }

variable "linux_vm_name" {
  type = string
}

variable "size" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "snet_bastion_name" {
  type = string
  default = "AzureBastionSubnet"
}
