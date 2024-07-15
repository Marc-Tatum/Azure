# We dont want names hardcoded in our code

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."

}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources"

}
variable "azurerm_virtual_network" {
  description = "The name of the azure virtual network"

}
variable "subnet1" {
  description = "The name of the subnet"
}
variable "address_prefix" {
  description = "The value of the subnet"
}