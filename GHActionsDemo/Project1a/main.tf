provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "example" {
  name     = "githubactionazure"
  location = "South Central US"
}
