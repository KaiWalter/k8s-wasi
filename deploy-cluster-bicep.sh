#!/bin/sh
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)
RESOURCE_PREFIX="k8s-wasi"
LOCATION="westeurope"

az deployment sub create \
    --template-file ./resource-group.bicep \
    --location $LOCATION \
    -p location=$LOCATION \
       resourcePrefix=$RESOURCE_PREFIX

az aks get-credentials --resource-group $RESOURCE_PREFIX-rg --name $RESOURCE_PREFIX