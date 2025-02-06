terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.16.0"
    }
  }
}

provider "azurerm" {
  features {
  }
    subscription_id = "a6b8c895-a166-49f8-8a6e-2a762d07134a"
}

terraform {
  backend "local" {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspac" {
  name                = "acctest-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "virtual_network" {
  source                     = "./modules/virtual_network"
  name                       = "${var.virtual_network_name}-${var.environment_name}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspac.id
  address_space              = ["10.0.0.0/16"]

  subnets = [
    {
      name : var.snet_vm_name
      address_prefixes : ["10.0.1.0/24"]
      private_link_service_network_policies_enabled: false
      services_endpoint : []
    },
    {
      name : var.snet_bastion_name
      address_prefixes : ["10.0.2.0/24"]
      private_link_service_network_policies_enabled: false
      services_endpoint : []
    }
  ]
}

module "virtual_machine_linux" {
  source                = "./modules/virtual_machine"
#  agent_count           = var.agent_count
  name                  = "${var.linux_vm_name}-${var.environment_name}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  subnet_id             = module.virtual_network.subnet_ids[var.snet_vm_name]
  size                  = var.size
  password              = var.password 
  storage_account_type  = var.storage_account_type

  depends_on            = [ module.virtual_network ]
}

module "bastion_host" {
  source              = "./modules/bastion_host"
  name                = "${var.linux_vm_name}-${var.environment_name}" 
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.virtual_network.subnet_ids[var.snet_bastion_name]
}