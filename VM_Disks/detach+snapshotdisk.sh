#!/bin/bash

##Parameters.##
read -p "Enter the disk name: " diskname
read -p "Enter the resource group name: " resourcegroup
read -p "Enter the name of the vm: " vmname
ssname=$vmname.snapshot

az vm disk detach \
-resource-group $resourcegroup \
--vm-name $vmname \
--name $diskname

az snapshot create \
--name $ssname 
--resource-group $resourcegroup \
--source $diskname

az snapshot list \
--resource-group $resourcegroup \
--output table