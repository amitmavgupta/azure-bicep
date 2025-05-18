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

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: '${prefix}-aks-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.0.0/16'
        '2001:db8:deca::/48'
      ]
    }
  }
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2025-03-01' = {
  name: '${prefix}-${clusterName}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    networkProfile: {
      networkPlugin: 'none'
      ipFamilies: [
        'IPv4'
        'IPv6'
      ]
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
        osType: 'Linux'
        osDiskSizeGB: 30
        enableAutoScaling: autoScale
        minCount: minCount
        maxCount: maxCount
        maxPods: 110
      }
      {
        name: 'user'
        mode: 'User'
        count: 1
        vmSize: 'Standard_B4ms'
        osType: 'Linux'
        osDiskSizeGB: 30
        enableAutoScaling: autoScale
        minCount: minCount
        maxCount: maxCount
        maxPods: 110
      }
    ]
  }
}
