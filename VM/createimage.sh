#!/bin/bash

##Parameters.##
read -p "Enter the name of the vm: " vmname
read -p "Enter the resource group: " resourcegroup
read -p "Enter a name for the image: " imagename


##You need to be signed-in into the VM that you want to image capture.##
##Deprovision the VM and sign out:##
sudo waagent -deprovision+user -y
exit

##Create the image:##
az vm stop \
--name $vmname \
--resource-group $resourcegroup

az vm deallocate \
--resource-group $resourcegroup \
--name $vmname

az vm generalize \
--resource-group $resourcegroup \
--name $vmname

az image create \
--name $imagename \
--resource-group $resourcegroup\
--source $vmname

az image list \
--resource-group $resourcegroup \
--output table 

