
resource "azurerm_resource_group" "August" {
  name     = "August"
  location = "eastus"
}

resource "azurerm_virtual_network" "devnetwork" {
  name                = "devnetwork"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  address_space       = ["10.100.0.0/16"]
}

resource "azurerm_subnet" "devsubnet" {
  name                 = "devsubnet"
  resource_group_name  = azurerm_resource_group.August.name
  virtual_network_name = azurerm_virtual_network.devnetwork.name
  address_prefixes     = ["10.100.1.0/24"]
}

resource "azurerm_virtual_network" "testnetwork" {
  name                = "testnetwork"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  address_space       = ["10.200.0.0/16"]
}


resource "azurerm_subnet" "testsubnet" {
  name                 = "testsubnet"
  resource_group_name  = azurerm_resource_group.August.name
  virtual_network_name = azurerm_virtual_network.testnetwork.name
  address_prefixes     = ["10.200.1.0/24"]
}

resource "azurerm_virtual_network" "hubnetwork" {
  name                = "hubnetwork"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "hubsubnet" {
  name                 = "hubsubnet"
  resource_group_name  = azurerm_resource_group.August.name
  virtual_network_name = azurerm_virtual_network.hubnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}
