terraform {
  # use tf init -backend-config=backend.hcl to get all parameters
  backend "s3" {
    key = "azure/stage/services/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  prefixname = "mcloudify"
  location   = "westus"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.prefixname}-resource-group"
  location = local.location
}

module "basic_vm" {
  source     = "../../modules/basic_vm"
  prefixname = local.prefixname
  rgname     = azurerm_resource_group.rg.name
}

module "blob_storage" {
  source     = "../../modules/blob_storage"
  prefixname = local.prefixname
  rgname     = azurerm_resource_group.rg.name
}