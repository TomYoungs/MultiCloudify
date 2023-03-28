resource "azurerm_storage_account" "storeaccount" {
  name                     = "${var.prefixname}storeac"
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storecontainer" {
  name                  = "${var.prefixname}container"
  storage_account_name  = azurerm_storage_account.storeaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storeblob" {
  name                   = "${var.prefixname}blobstore"
  storage_account_name   = azurerm_storage_account.storeaccount.name
  storage_container_name = azurerm_storage_container.storecontainer.name
  type                   = "Block"
}