# aks.bicep

## Usage

Here is a basic example of how to use this Bicep module:

```bicep
module reference_name 'path_to_module | container_registry_reference' = {
  name: 'deployment_name'
  params: {
    // Required parameters
    clusterName:
    kubernetesVersion:
    prefix:

    // Optional parameters
    autoScale: true
    enableRBAC: true
    location: '[resourceGroup().location]'
    maxCount: 3
    minCount: 1
  }
}
```

> Note: In the default values, strings enclosed in square brackets (e.g. '[resourceGroup().location]' or '[__bicep.function_name(args...)']) represent function calls or references.

## Resources

| Symbolic Name | Type | Description |
| --- | --- | --- |
| aksCluster | [Microsoft.ContainerService/managedClusters](https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters) |  |

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