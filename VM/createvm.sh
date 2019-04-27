#!bin/bash

##Script to create a brand new VM##

##Check if azure is installed##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

##Parameters.##
read -p "Enter the resource group: " resourcegroup
read -p "Enter a location for resource group: " location
read -p "Enter a name for the VM: " vmname
read -p "Enter the image: UbuntuLTS, Centos, Devian, or Win2019Datacenter, or a stored image " image
read -p "Enter the size: " size

##Create a resource group. Check if resource group already exists. If so, skip.##
verifyrg=$(az group exists --name $resourcegroup | grep -E true)
if [ $verifyvrg=true ]; then
echo "Resource group already exists." 0>&2
else
az group create --name $resourcegroup --location $location
exit 0
fi

##Create a VM.##
##Verify that there are no duplicates for the VM.##
##ssh keys are stored in /.ssh directory.##
##If no location is given, it defaults to the location given in the resource group.##

verifyvm=$(az vm show --resource-group $resourcegroup --name $vmname | grep -E $vmname)
if [ -z $verifyvm ]; then
echo "VM name already in use. Please choose a different name and try again." 1>&2
else
az vm create \
    --resource-group $resourcegroup \
    --name $vmname \
    --image $image \
    --size $size \
    --generate-ssh-keys
    --admin-username $username \
    --no-wait
echo "VM created. Thank you for using Azure."
az vm show \
--resource-group $resourcegroup \
--name vmname \
--show-details
--output table
exit 0
fi