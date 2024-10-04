
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

resource "azurerm_network_interface" "hubnic" {
  name                = "hubnic"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hubsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "hubvm" {
  name                = "hubvm"
  resource_group_name = azurerm_resource_group.August.name
  location            = azurerm_resource_group.August.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.hubnic.id
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
