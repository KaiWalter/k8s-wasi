param location string
param clusterName string

param sysPoolNodeCount int = 1
param sysPoolVmSize string = 'Standard_B2s'
param wasiPoolNodeCount int = 1
param wasiPoolVmSize string = 'Standard_B2s'

resource aks 'Microsoft.ContainerService/managedClusters@2022-04-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: clusterName
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'sys'
        count: sysPoolNodeCount
        vmSize: sysPoolVmSize
        mode: 'System'
      }
      {
        name: 'wasi'
        count: wasiPoolNodeCount
        vmSize: wasiPoolVmSize
        workloadRuntime: 'WasmWasi'
      }
    ]
  }
}
