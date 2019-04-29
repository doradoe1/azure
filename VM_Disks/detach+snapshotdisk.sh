#!/bin/bash

##Parameters.##
read -p "Enter the disk name: " diskname
read -p "Enter the resource group name: " resourcegroup
read -p "Enter the name of the vm: " vmname
ssname=$vmname.snapshot

##Detach the disk from the VM:##
az vm disk detach \
-resource-group $resourcegroup \
--vm-name $vmname \
--name $diskname

##Creating the snapshot:##
az snapshot create \
--name $ssname 
--resource-group $resourcegroup \
--source $diskname

##Wait five seconds before verifying the creation of the snapshot:##
sleep 5s

##Vefifying that the snapshot was created:##
az snapshot list \
--resource-group $resourcegroup \
--output table