output "network_security_group_name" {
  description = "Name of the network security group"
  value       = azurerm_network_security_group.terraform_nsg.name
}
output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.terraform_rg.name
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.terraform_vnet.name
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.terraform_vnet.address_space
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.terraform_subnet.name
}
