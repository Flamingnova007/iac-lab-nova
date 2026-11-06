targetScope = 'resourceGroup'

@description('Azure region for all resources')
param location string = 'uaenorth'

@description('Tags applied to every resource')
param tags object = {
  Owner: 'Arsh'
  Week: '9'
}

module nsgSpokeA 'modules/nsg.bicep' = {
  name: 'deploy-nsg-spokea'
  params: {
    nsgName: 'arsh-iac-spokea-nsg'
    location: location
    tags: tags
  }
}

module nsgSpokeB 'modules/nsg.bicep' = {
  name: 'deploy-nsg-spokeb'
  params: {
    nsgName: 'arsh-iac-spokeb-nsg'
    location: location
    tags: tags
  }
}

module vnetHub 'modules/vnet.bicep' = {
  name: 'deploy-vnet-hub'
  params: {
    vnetName: 'arsh-iac-hub-vnet'
    location: location
    tags: tags
    addressPrefix: '10.0.0.0/16'
    subnets: [
      {
        name: 'snet-hub'
        addressPrefix: '10.0.0.0/24'
        nsgId: ''
      }
    ]
  }
}

module vnetSpokeA 'modules/vnet.bicep' = {
  name: 'deploy-vnet-spokea'
  params: {
    vnetName: 'arsh-iac-spokea-vnet'
    location: location
    tags: tags
    addressPrefix: '10.1.0.0/16'
    subnets: [
      {
        name: 'snet-testing'
        addressPrefix: '10.1.0.0/24'
        nsgId: nsgSpokeA.outputs.nsgId
      }
    ]
  }
}

module vnetSpokeB 'modules/vnet.bicep' = {
  name: 'deploy-vnet-spokeb'
  params: {
    vnetName: 'arsh-iac-spokeb-vnet'
    location: location
    tags: tags
    addressPrefix: '10.2.0.0/16'
    subnets: [
      {
        name: 'snet-workload-prod'
        addressPrefix: '10.2.0.0/24'
        nsgId: nsgSpokeB.outputs.nsgId
      }
    ]
  }
}

module peeringSpokeA 'modules/peering.bicep' = {
  name: 'deploy-peering-spokea'
  params: {
    hubVnetName: vnetHub.outputs.vnetName
    spokeVnetName: vnetSpokeA.outputs.vnetName
  }
}

module peeringSpokeB 'modules/peering.bicep' = {
  name: 'deploy-peering-spokeb'
  params: {
    hubVnetName: vnetHub.outputs.vnetName
    spokeVnetName: vnetSpokeB.outputs.vnetName
  }
  dependsOn: [
    peeringSpokeA
  ]
}
