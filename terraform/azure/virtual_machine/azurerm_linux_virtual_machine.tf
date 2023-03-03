resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"

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
    user        = "adminuser"
    password    = "P@ssw0rd1234!"
    host        = azurerm_linux_virtual_machine.example.public_ip_address
    port        = 22
    timeout     = "2m"
  }
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.example.public_ip_address
}