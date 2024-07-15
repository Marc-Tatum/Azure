
# Create a resource group

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Create a VNET

resource "azurerm_virtual_network" "vnet1" {
  name                = var.azurerm_virtual_network
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.20.0.0/16"]
  dns_servers         = ["10.20.0.4", "10.20.0.5"]

  subnet {
    name           = var.subnet1
    address_prefix = var.address_prefix
  }

  #   subnet {
  #     name           = "subnet2"
  #     address_prefix = "10.20.2.0/24"
  #     #security_group = azurerm_network_security_group.example.id
  #   }

  #   tags = {
  #     environment = "terraform-demo"
  #   }

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.20.0.64/27"
  }
}

