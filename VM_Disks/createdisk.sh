#!/bin/bash

##Parameters.##
read -p "Enter the disk name: " diskname
read -p "Enter the resource group name: " resourcegroup
read -p "Enter the os type: " os
read -p "Enter the size (read in gb) for the disk: "  sizegb

az disk create --name $diskname \
    --resource-group $resourcegroup \         
    --os-type $os \
    --size-gb $sizegb \
    --no-wait