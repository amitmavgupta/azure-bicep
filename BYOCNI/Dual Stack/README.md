## Resources

| Symbolic Name | Type | Description |
| --- | --- | --- |
| aksCluster | [Microsoft.ContainerService/managedClusters](https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters) |  |
| vnet | [Microsoft.Network/virtualNetworks](https://learn.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks) |  |

## Parameters

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| autoScale | bool | Enable auto scaling | true |
| clusterName | string | Name of the AKS cluster |  |
| enableRBAC | bool | Enable RBAC | true |
| kubernetesVersion | string | Kubernetes Version |  |
| location | string | Location of the AKS cluster | "[resourceGroup().location]" |
| maxCount | int | maximum number of nodes | 3 |
| minCount | int | minimum number of nodes | 1 |
| prefix | string | Prefix for deployment |  |