@description('Location of the AKS cluster')
param location string = resourceGroup().location

@description('Name of the AKS cluster')
param clusterName string

@description('Kubernetes Version')
param kubernetesVersion string

@description('Enable RBAC')
param enableRBAC bool = true

@description('Enable auto scaling')
param autoScale bool = true

@description('minimum number of nodes')
param minCount int = 1

@description('maximum number of nodes')
param maxCount int = 3

@description('Prefix for deployment')
param prefix string

resource vnet 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: '${prefix}-aks-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.10.0/24'
      ]
    }
  }
}

resource aks_subnet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  name: '${prefix}-aks-subnet'
  parent: vnet
  properties: {
    addressPrefix: '192.168.10.0/24'
  }
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-03-02-preview' = {
  name: '${prefix}-${clusterName}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    networkProfile: {
      networkPlugin: 'none'
      podCidr: '10.10.0.0/21'
      serviceCidr: '10.20.0.0/24'
      dnsServiceIP: '10.20.0.10'
    }
    kubernetesVersion: kubernetesVersion
    enableRBAC: enableRBAC
    dnsPrefix: '${prefix}-${clusterName}'
    agentPoolProfiles: [
      {
        name: 'system'
        mode: 'System'
        count: 1
        vmSize: 'Standard_B4ms'
        osSKU: 'AzureLinux'
        osType: 'Linux'
        osDiskSizeGB: 30
        enableAutoScaling: autoScale
        minCount: minCount
        maxCount: maxCount
        vnetSubnetID: aks_subnet.id
        maxPods: 110
      }
      {
        name: 'user'
        mode: 'User'
        count: 1
        vmSize: 'Standard_B4ms'
        osSKU: 'AzureLinux'
        osType: 'Linux'
        osDiskSizeGB: 30
        enableAutoScaling: autoScale
        minCount: minCount
        maxCount: maxCount
        vnetSubnetID: aks_subnet.id
        maxPods: 110
      }
    ]
  }
}
