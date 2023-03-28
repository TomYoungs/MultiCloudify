resource "azurerm_static_site" "example" {
  name                = "${var.prefixname}-static-site"
  resource_group_name = var.rg
  location            = var.location
}