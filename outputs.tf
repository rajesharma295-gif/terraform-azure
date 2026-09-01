output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.terraform_rg.name
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.terraform_vnet.name
}

output "vnet_address_space" {
  description = "VNet address space"
  value       = azurerm_virtual_network.terraform_vnet.address_space
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.terraform_subnet.name
}

output "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  value       = azurerm_subnet.terraform_subnet.address_prefixes
}
output "public_ip_address" {
  description = "Public IP address of the Linux VM"
  value       = azurerm_public_ip.terraform_pip.ip_address
}

output "ssh_command" {
  description = "SSH command to connect to the Linux VM"
  value       = "ssh azureadmin@${azurerm_public_ip.terraform_pip.ip_address}"
}
