terraform {
  required_version = ">= 1.3.9"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefixname}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_subnet" "frontendsubnet" {
  name                 = "${var.prefixname}-frontendSubnet"
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "vmpublicip" {
  name                = "pip1"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

//virtual_machine

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.prefixname}-vm"
  location              = var.location
  resource_group_name   = var.rgname
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.size
  admin_username        = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azure-vm-tf-id.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefixname}-nic"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "${var.prefixname}-nic-configuration"
    subnet_id                     = azurerm_subnet.frontendsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vmpublicip.id
  }
}

