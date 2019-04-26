#!/bin/bash

az vm disk detach \
    -g myResourceGroup \
	--vm-name myVm \
	-n myDataDisk