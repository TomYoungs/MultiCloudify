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
  prefixname = "multicloudify"
  location   = "westus"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.prefixname}-resource-group"
  location = local.location
}

module "basic_vm" {
  source     = "../../modules/basic_vm"
  prefixname = "multicloudify-azure"
  rgname     = azurerm_resource_group.rg.name
}

