provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./resource_group"
  rg_name = "example-rg"
}

module "network" {
  source = "./network"
  vnet_name = "example-vnet"
  rg_name = module.resource_group.rg_name
}

module "virtual_machine" {
  source = "./virtual_machine"
  vm_name = "example-vm"
  nic_id = module.network.nic_id
}
