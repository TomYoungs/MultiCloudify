provider "google" {
  project = "my-project-id" # replace with your GCP project ID
  region  = "us-west1"     # replace with your desired region
}

module "network" {
  source = "./network"
}

module "subnet" {
  source = "./subnet"
  network_self_link = module.network.network_self_link
}

module "instance" {
  source = "./instance"
  subnet_self_link = module.subnet.subnet_self_link
}
