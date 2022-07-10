# k8s-wasi

Test K8S with WASI

## prerequisites

- Azure CLI with Bicep
- kubectl `az aks install-cli`

## get started

```shell
az feature register --name WasmNodePoolPreview --namespace Microsoft.ContainerService
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/WasmNodePoolPreview')].{Name:name,State:properties.state}"
az provider register --namespace Microsoft.ContainerService
```

## deploy

deploy and check whether WASI node pool is available

```
./deploy-cluster.sh
kubectl get nodes -o wide
```

az aks nodepool add \
    --resource-group k8s-wasi-rg \
    --cluster-name k8s-wasi \
    --name k8swasiwasi \
    --node-count 1 \
    --workload-runtime wasmwasi \
    --debug

az aks nodepool list --resource-group k8s-wasi-rg --cluster-name k8s-wasi

## source links

- [Docs sample - Create WebAssembly System Interface (WASI) node pools in Azure Kubernetes Service (AKS) to run your WebAssembly (WASM) workload (preview)](https://docs.microsoft.com/en-us/azure/aks/use-wasi-node-pools)
- [Create AKS with Bicep by Thomas Stringer](https://trstringer.com/create-aks-bicep/)


## helpful links

- [WASM setup for AKS by Dennis Zielke](https://github.com/denniszielke/container_demos/blob/master/wasm.md)
- [AKS API](https://docs.microsoft.com/en-us/rest/api/aks/managed-clusters/create-or-update)
