#!/bin/bash

##Parameters.##
read -p "Enter the name of the vm: " vmname
read -p "Enter the resource group: " resourcegroup
read -p "Enter a name for the image: " imagename

##Verify that the VM exists, its resource group and that the image name is not in use:##

verifyvm=$(az vm list \
--resource-group $resourcegroup \
-d \
--query [].name \
| grep -E $vmname)

if [ -z $verifyvm ]; then
echo "Invalid/non-existent VM. Please check your input and try again."
1>&2
else
echo "Valid VM name." 
exit 0
fi

verifyrg=$(az group exists \
--name $resourcegroup \
| grep -E true)

if [ $verifyvrg=true ]; then
echo "Valid Resource group." 0>&2
else
echo "Invalid/non-existent Resource group. Please check your input and try again."
exit 1
fi

verifyimage=$(az image list \
--resource-group $resourcegroup \
--output table \
| grep -E $imagename)

if [ -z $verifyimage ]; then
echo "Valid Image name." 0>&2
else
echo "Image name in use. Please choose another name for the image."
exit 1
fi 

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

