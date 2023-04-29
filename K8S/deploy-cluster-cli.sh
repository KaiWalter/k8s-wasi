#!/bin/sh
# https://learn.microsoft.com/en-us/azure/aks/use-wasi-node-pools

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)
RESOURCE_PREFIX="kw-k8s-wasi"
RESOURCE_GROUP="$RESOURCE_PREFIX-rg"
CLUSTER_NAME="$RESOURCE_PREFIX"
LOCATION="northeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION

az aks create -g $RESOURCE_GROUP -n $CLUSTER_NAME \
    --enable-managed-identity \
    --node-count 3 \
    --node-vm-size Standard_B2s \
    --node-osdisk-size 32 \
     --enable-addons monitoring --generate-ssh-keys

az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME

az aks nodepool add \
    -g $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    --name wasi \
    --node-count 1 \
    --labels spin-enabled=true slight-enabled=true \
    --node-vm-size Standard_B2s \
    --workload-runtime wasmwasi 

az aks nodepool show -g $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    -n wasi
