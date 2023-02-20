// Global Parameters
param location string = resourceGroup().location
param tags object
param vnetInfo object 
param snetsInfo array

//param privateDnsZonesInfo array //Azure Bastion doesn't support private zones
param centrilazedResolverDns bool
param dnsResolverInboundEndpointIp string
param bastionName string

module vnetResources '../../modules/Microsoft.Network/vnet.bicep' = {
  name: 'vnetResources_Deploy'
  params: {
    location: location
    tags: tags
    vnetInfo: vnetInfo
    snetsInfo: snetsInfo
    centrilazedResolverDns: centrilazedResolverDns
    dnsResolverInboundEndpointIp: dnsResolverInboundEndpointIp
  }
}

module bastion '../../modules/Microsoft.Network/bastion.bicep' = {
  name: 'bastionResources_Deploy'
  dependsOn: [
    vnetResources
  ]
  params: {
    name: bastionName
    location: location
    tags: tags
    vnetName: vnetInfo.name
    vnetResourceGroupName: resourceGroup().name
  }
}
