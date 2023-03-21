terraform {
  # use tf init -backend-config=backend.hcl to get all parameters
  backend "s3" {
    key = "azure/stage/services/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "basic_vm" {
  source     = "../../modules/basic_vm"
  prefixname = "multicloudify-azure"
}
