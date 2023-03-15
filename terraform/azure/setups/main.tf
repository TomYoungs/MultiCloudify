provider "azurerm" {
  features {}
}

module "basic_vm" {
  source = "../modules/basic_vm"
  prefixname = "multicloudify-azure"
}
