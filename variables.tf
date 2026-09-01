variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}
variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "rg-terraform-lab"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-terraform-lab"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "subnet-terraform-lab"
}

variable "vm_name" {
  description = "Name of the Linux virtual machine"
  type        = string
  default     = "vm-terraform-lab"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_DC1ds_v3"
}
