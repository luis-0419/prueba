output "name" {
  value = azurerm_bastion_host.bastion_host.name
}

output "id" {
  value = azurerm_bastion_host.bastion_host.id
}

output "pip" {
  value = azurerm_public_ip.pip.id
}