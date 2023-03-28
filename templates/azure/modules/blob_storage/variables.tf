variable "location" {
  description = "deployment location of resource(s)"
  default     = "westus"
}

variable "rgname" {
  description = "name of the resource group that the VM(s) will live in"
}

variable "prefixname" {
  description = "prefix for name e.g. *prefixname*-resource-group"
  default     = "mcloudify"
}
