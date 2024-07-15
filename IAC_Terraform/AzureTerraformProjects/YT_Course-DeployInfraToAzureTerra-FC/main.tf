provider "azurerm" {
    features {}
}

# Create a resource group

resource "azurerm_resource_group" "resource_group" {
    name = "rg-terraform-demo"
    location = "centralus"
}

# Create a VNET

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-terraform-demo"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.20.0.0/16"]
  dns_servers         = ["10.20.0.4", "10.20.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.20.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.20.2.0/24"
    #security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "terraform-demo"
  }
  
  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.20.0.64/27"
  }
}

