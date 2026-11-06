param vnetName string
param location string
param tags object

@description('Address space of the VNet')
param addressPrefix string

@description('Subnets as objects with name, addressPrefix and nsgId (empty string when no NSG)')
param subnets array

resource vnet 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        networkSecurityGroup: empty(subnet.nsgId) ? null : {
          id: subnet.nsgId
        }
      }
    }]
  }
}

output vnetId string = vnet.id
output vnetName string = vnet.name
