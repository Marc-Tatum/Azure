
resource "azurerm_resource_group" "August" {
  name     = "August"
  location = "northcentralus"
}


resource "azurerm_virtual_network_peering" "dev-to-hub" {
  name                         = "hubtodev"
  virtual_network_name         = azurerm_virtual_network.devnetwork.name
  remote_virtual_network_id    = azurerm_virtual_network.hubnetwork.id
  resource_group_name          = azurerm_resource_group.August.name
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

}

resource "azurerm_virtual_network_peering" "hub-to-dev" {
  name                         = "hubtodev"
  virtual_network_name         = azurerm_virtual_network.hubnetwork.name
  remote_virtual_network_id    = azurerm_virtual_network.devnetwork.id
  resource_group_name          = azurerm_resource_group.August.name
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}




resource "azurerm_virtual_network_peering" "test-to-hub" {
  name                         = "hubtotest"
  virtual_network_name         = azurerm_virtual_network.testnetwork.name
  remote_virtual_network_id    = azurerm_virtual_network.hubnetwork.id
  resource_group_name          = azurerm_resource_group.August.name
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

}

resource "azurerm_virtual_network_peering" "hub-to-test" {
  name                         = "hubtotest"
  virtual_network_name         = azurerm_virtual_network.hubnetwork.name
  remote_virtual_network_id    = azurerm_virtual_network.testnetwork.id
  resource_group_name          = azurerm_resource_group.August.name
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}


resource "azurerm_route_table" "rtbdev" {
  name                = "rtbdev"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  tags = {
    environment = "Prod"
  }
}

resource "azurerm_route" "routetotest" {
  name                   = "routetotest"
  resource_group_name    = azurerm_resource_group.August.name
  route_table_name       = azurerm_route_table.rtbdev.name
  address_prefix         = "10.200.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.2.4"
}


resource "azurerm_route_table" "rtbtest" {
  name                = "rtbtest"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  tags = {
    environment = "Prod"
  }
}
resource "azurerm_route" "routetodev" {
  name                   = "routetodev"
  resource_group_name    = azurerm_resource_group.August.name
  route_table_name       = azurerm_route_table.rtbtest.name
  address_prefix         = "10.100.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.2.4"
}
