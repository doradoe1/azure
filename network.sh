#!/bin/bash
#<--------------------------------------------Full Network Scripts----------------------------------------------->#
#------------------------------------------------------------------------------------------------------------------#
##Parameters:




#-----------------------------------------------------------------------------------------------------------------#
##Parameters:
read -p "Enter the name of the network: " virtualnetwork
read -p "Enter the name of the resource group: " resourcegroup
read -p "Enter the netwrok address prefix: " nap
read -p "Enter the mask of the address prefix: " mask


##Create a virtual network:
az network vnet create \
-g $resourcegroup \
-n $virtualnetwork \
--address-prefix $nap/$mask
#-----------------------------------------------------------------------------------------------------------------#
##Parameters:
read -p "Enter the name of the network: " virtualnetwork
read -p "Enter the name of the resource group: " resourcegroup
read -p "Enter the address prefix for the subnet: " sap
read -p "Enter the mask of the address prefix: " mask
read -p "Enter the name of the subnet: " subnet

##Create subnets in the network:

az network vnet subnet create \
--address-prefixes $sap/$mask \
--name $subnet \
--resource-group $resourcegroup \
--vnet-name $virtualnetwork

#----------------------------------------------------------------------------------------------------------------#
##Parameters:
read -p "Enter a name for the VM's: " vmname
read -p "Enter the name of the resource group: " resourcegroup
read -p "Enter the size for the VM's (Standard_B2s commonly used): " size
read -p "Enter the image for the VM's (UbuntuLTS): " image
read -p "Enter the name of the virtual network: " virtualnetwork

##Create the VMs:
for i in 1 2 3 4
do
    az vm create \
    --resource-group $resourcegroup \
    --name $vmname$i \
    --size $size \
    --image $image \
    --admin-username user$i \
    --generate-ssh-keys \
    --vnet-name $virtualnetwork
done
#----------------------------------------------------------------------------------------------------------------#
##Parameters:
read -p "Enter a name for the firewall: " firewallname
read -p "Enter the resoure group: " resourcegroup
read -p "Enter the location for the firewall: " firewalllocation
read -p "Enter the name of the ip configuration: " ipconfigname
read -p "Enter the public ip address in CIDR format: " ipaddress
read -p "Enter the private ip address in CIDR format: " pipaddress
read -p "Enter the name of the virtual network: " virtualnetwork


#Firewall create:
az network firewall create \
--name $firewallname \
--resource-group $resourcegroup \
--location $firewalllocation

#Firewall show:
az network firewall show \
--name $firewallname \
--resource-group $resourcegroup

#Firewall Ip Configuration:
az network firewall ip-config create \
--firewall-name $firewallname \
--name $ipconfigname \
--public-ip-address $ipaddress \
--resource-group $resourcegroup \
--vnet-name $virtualnetwork \
--private-ip-address $pipaddress

az network firewall application-rule create \ 
--collection-name
--firewall-name
--name
--protocols
--resource-group
[--action {Allow, Deny}]
[--description]
[--fqdn-tags]
[--priority]
[--source-addresses]
[--target-fqdns]
