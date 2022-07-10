#!/bin/sh
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)
RESOURCE_PREFIX="k8s-wasi"
RESOURCE_GROUP="$RESOURCE_PREFIX-rg"
CLUSTER_NAME="$RESOURCE_PREFIX"
LOCATION="westeurope"

az group create --name $RESOURCE_GROUP --location $LOCATION

az aks create -g $RESOURCE_GROUP -n $CLUSTER_NAME \
    --enable-managed-identity
    --node-count 1
    --node-vm-size Standard_B2s \
    --node-osdisk-size 32 \
     --enable-addons monitoring --generate-ssh-keys

az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME

az aks nodepool add \
    -g $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    --name mywasipool \
    --node-count 1 \
    --workload-runtime wasmwasi 

az aks nodepool show -g $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    -n mywasipool