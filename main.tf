terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_rg" {
  name     = "rg-terraform-lab"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "terraform_vnet" {
  name                = "vnet-terraform-lab"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "terraform_subnet" {
  name                 = "subnet-terraform-lab"
  resource_group_name  = azurerm_resource_group.terraform_rg.name
  virtual_network_name = azurerm_virtual_network.terraform_vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}
