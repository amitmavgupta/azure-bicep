# What is the main purpose of the repo?
This repo will discuss how to deploy **AKS clusters with Bicep**:

* Bring your own CNI (BYOCNI)
* Bring your own CNI (BYOCNI) with Dual Stack
* Bring your own CNI (BYOCNI) with Azure Linux as the host OS
* Isovalent Enterprise for Cilium in Azure Marketplace.
* Isovalent Enterprise for Cilium in Azure Marketplace (Azure Linux as the host OS).
* Azure CNI powered by Cilium (Overlay Mode) with Cilium as the Network Policy
* Azure CNI powered by Cilium (Overlay Mode) with Azure Linux as the host OS

# Ensure you have enough quota
Go to the Subscription blade, navigate to "Usage + Quotas", and make sure you have enough quota for the following resources:

* Regional vCPUs
* Standard Dv4 Family vCPUs

# How to get going with Bicep?

* name=aksbicep
* locationname=canadacentral
* resourceGroup=aksbicep
* az group create --name $name --location $locationname
* az deployment group validate -f aks.bicep -p aks.bicepparam -g $resourceGroup
* az deployment group create -f aks.bicep -p aks.bicepparam -g $resourceGroup
* az group delete --name $resourceGroup
