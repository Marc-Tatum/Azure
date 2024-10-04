
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


resource "azurerm_network_interface" "testnic" {
  name                = "testnic"
  location            = azurerm_resource_group.August.location
  resource_group_name = azurerm_resource_group.August.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.testsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "testvm" {
  name                = "testvm"
  resource_group_name = azurerm_resource_group.August.name
  location            = azurerm_resource_group.August.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.testnic.id
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


