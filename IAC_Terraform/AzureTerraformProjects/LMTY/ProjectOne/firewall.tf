

resource "azurerm_subnet" "example" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.August.name
  virtual_network_name = azurerm_virtual_network.hubnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "testpip"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "example" {
  name                = "testfirewall"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}



resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "ALLOWSPOKEVNETCOMMUNICATION"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.August.name
  priority            = 150
  action              = "Allow"

  rule {
    name = "ROUTETOTEST"

    source_addresses = [
      "10.100.0.0/16",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "10.200.0.0/16"
    ]

    protocols = [
      "Any"
    ]
  }

  rule {
    name = "ROUTETODEV"

    source_addresses = [
      "10.200.0.0/16",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "10.100.0.0/16"
    ]

    protocols = [
      "Any"
    ]
  }



  rule {
    name = "ROUTETOWEB"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "Any"
    ]
  }

}


resource "azurerm_firewall_nat_rule_collection" "example" {
  name                = "allowrdpdev"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.August.name
  priority            = 200
  action              = "Dnat"

  rule {
    name = "testrule"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      azurerm_public_ip.example.ip_address
    ]

    translated_port = 3389

    translated_address = "10.100.1.4"

    protocols = [
      "TCP",

    ]
  }
}
