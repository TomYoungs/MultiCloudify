terraform {
    required_version = ">= 1.3.9"
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefixname}-resource-group"
  location = var.location
}

//virtual_machine
resource "azurerm_linux_virtual_machine" "example" {
  name                = "${var.prefixname}-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  os_disk {
    name              = "example-os-disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  connection {
    type        = "ssh"
    user        = var.admin_username
    password    = var.admin_password
    host        = azurerm_linux_virtual_machine.example.public_ip_address
    port        = 22
    timeout     = "2m"
  }
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.example.public_ip_address
}