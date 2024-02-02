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

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-03-02-preview' = {
  name: '${prefix}-${clusterName}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    networkProfile: {
      networkPlugin: 'azure'
      networkPluginMode: 'overlay'
      networkDataplane: 'cilium'
      networkPolicy: 'cilium'
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

resource extensionResource 'Microsoft.KubernetesConfiguration/extensions@2022-11-01' = {
  name: 'cilium'
  scope: aksCluster
  plan: {
    name: 'isovalent-cilium-enterprise-base-edition'
    product: 'isovalent-cilium-enterprise'
    publisher: 'isovalentinc1122334455667'
    version: '1.10'
  }
  properties: {
    aksAssignedIdentity: {
      type: 'SystemAssigned'
    }
    autoUpgradeMinorVersion: false
    configurationProtectedSettings: {}
    configurationSettings: {}
    extensionType: 'Isovalent.CiliumEnterprise.One'
    releaseTrain: 'stable'
    scope: {
      cluster: {
        releaseNamespace: 'kube-system'
      }
    }
  }
}
