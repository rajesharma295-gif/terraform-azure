resource "azurerm_network_security_group" "terraform_nsg" {
  name                = "nsg-terraform-lab"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
}

resource "azurerm_subnet_network_security_group_association" "terraform_nsg_association" {
  subnet_id                 = azurerm_subnet.terraform_subnet.id
  network_security_group_id = azurerm_network_security_group.terraform_nsg.id
}
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
  location = var.location
}

resource "azurerm_virtual_network" "terraform_vnet" {
  name                = "vnet-terraform-lab"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "terraform_subnet" {
  name                 = "subnet-terraform-lab"
  resource_group_name  = azurerm_resource_group.terraform_rg.name
  virtual_network_name = azurerm_virtual_network.terraform_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}
resource "azurerm_public_ip" "terraform_pip" {
  name                = "pip-terraform-lab"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "terraform_nic" {
  name                = "nic-terraform-lab"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terraform_pip.id
  }
}
resource "azurerm_linux_virtual_machine" "terraform_vm" {
  name                = "vm-terraform-lab"
  resource_group_name = azurerm_resource_group.terraform_rg.name
  location            = azurerm_resource_group.terraform_rg.location
  size                = "Standard_DC1ds_v3"
  admin_username      = "azureadmin"

  network_interface_ids = [
    azurerm_network_interface.terraform_nic.id
  ]

  admin_ssh_key {
    username   = "azureadmin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
resource "azurerm_network_security_rule" "allow_ssh" {
  name                       = "Allow-SSH"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.terraform_rg.name
  network_security_group_name = azurerm_network_security_group.terraform_nsg.name
}
resource "azurerm_network_security_rule" "allow_http" {
  name                        = "Allow-HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.terraform_rg.name
  network_security_group_name = azurerm_network_security_group.terraform_nsg.name
}
