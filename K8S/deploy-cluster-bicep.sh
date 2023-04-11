#!/bin/sh
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)
RESOURCE_PREFIX="k8s-wasi"
RESOURCE_GROUP="$RESOURCE_PREFIX-rg"
CLUSTER_NAME="$RESOURCE_PREFIX"
LOCATION="westeurope"

az deployment sub create \
    --template-file ./resource-group.bicep \
    --location $LOCATION \
    -p location=$LOCATION \
       resourcePrefix=$RESOURCE_PREFIX
      
az aks get-credentials -g $RESOURCE_GROUP --name $CLUSTER_NAME

az aks nodepool list -g $RESOURCE_GROUP --cluster-name $CLUSTER_NAME -o table