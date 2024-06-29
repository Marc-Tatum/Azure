resource tatumacr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'tatumacr'
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: false
  }
}
