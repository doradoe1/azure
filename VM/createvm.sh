#!bin/bash

##Script to create a brand new VM##

##Check if azure is installed##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

username=$1
resourcegroup=$2
location=$3
vmname=$4
image=$5
size=$6

##Step One: Login into Azure.##

az login -u $username

##Step Two: Verify that user has admin credentials to continue.##

echo "Verifying for Administrator Credentials. Please wait..."

check=$(az role assignment list  --include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" | grep -E $username)
if [ -z $check ]; then
echo "You must have administrator credentials to use access this functionality" 1>&2
exit 1
fi

##Step Three: Create a resource group.##
az group create --name $resourcegroup --location $location

##Step Four: Create a VM.##
##Verify that there are no duplicates for the VM.##
##ssh keys are stored in /.ssh directory.##
##If no location is given, it defaults to the location given in the resource group.##

check1=$(az vm show --resource-group $resourcegroup --name $vmname | grep -E $vmname)
if [ -z $check1 ]; then
echo "VM name already in use. Please choose a different name and try again." 1>$exit 1
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
fi