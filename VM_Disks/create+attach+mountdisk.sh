#!/bin/bash

##Parameters.##
read -p "Enter the disk name: " diskname
read -p "Enter the resource group name: " resourcegroup
read -p "Enter the os type: " os
read -p "Enter the size (read in gb) for the disk: "  sizegb
read -p "Enter the name of the vm: " vmname

az disk create \
--name $diskname \
--resource-group $resourcegroup \         
--os-type $os \
--size-gb $sizegb \
--no-wait

az vm disk attach \
--resource-group $resourcegroup \
--vm-name $vmname \
--name $diskname

sudo mkfs - ext4 /dev/sdc

sudo mkdir /media/$diskname
sudo mount /dev/sdc/ /media/$diskname