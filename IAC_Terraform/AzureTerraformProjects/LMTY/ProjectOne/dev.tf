
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

resource "azurerm_network_interface" "devnic" {
  name                = "devnic"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "devvm" {
  name                = "devvm"
  resource_group_name = azurerm_resource_group.August.name
  location            = azurerm_resource_group.August.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.devnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}


resource "azurerm_route" "routetoinet" {
  name                   = "routetoinet"
  resource_group_name    = azurerm_resource_group.August.name
  route_table_name       = azurerm_route_table.rtbdev.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.2.4"
}
