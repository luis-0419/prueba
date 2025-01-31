variable "name" {
  type = string 
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "password" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "agent_count" {
  type = number
  default = 2
}


