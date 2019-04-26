#!/bin/bash

az snapshot create \
	--name osDisk-backup 
    -g myResourceGroup \
	--source "$osDiskId" 

az snapshot list \
   -g myResourceGroup \
   - table