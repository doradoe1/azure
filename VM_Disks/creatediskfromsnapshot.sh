#!/bin/bash

##Parameters.##
read -p "Enter a name for the new disk: " newdisk
read -p "Enter the resource group name: " resourcegroup
read -p "Enter the name of the source disk (snapshot): " snapshotdisk

##Create a managed disk by copying an existing disk or snapshot.##
az disk create \
--resource-group $resourcegroup \
--name $newdisk \
--source $snapshotdisk \
--no-wait