#!/bin/bash

##Parameters.##
read -p "Enter a name: " name
read -p "Enter the resource group: " resourcegroup
read -p "Enter the source: " disksource
read -p "Enter the data disk sources: " dds
read -p "Enter a location for resource group: " location
read -p "Enter the os disk caching (None, ReadOnly, or ReadWrite): " odc
read -p "Enter the os type (Linux or Windows): " ostype
read -p "Enter the size: " size

az image create --name $name \
                --resource-group $resourcegroup\
                --source $disksource\
                --data-disk-sources $dds \
                --location $location \
                --os-disk-caching $odc \
                --os-type $ostype
