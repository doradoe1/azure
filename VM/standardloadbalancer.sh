#!/bin/bash

read -p "Enter an existent resource group: " resourcegroup
read -p "Enter the name for the load balancer: " loadbalancer
read -p "Enter the sku (standard or basic): " sku
read -p "Enter the name for the public ip: " ipname
read -p "Enter the protocol (http, https, or tcp): " protocol
read -p "Enter a name for the health probe: " healthprobe
read -p "Enter a port number: " port
read -p "Enter a name for the load balancer rule: " loadbalancerrule
read -p "Enter a name for the virtual network: " virtualnetwork
read -p "Enter a name for the subnet: " subnet
read -p "Enter a name for the network security rule: " networksecurityrule

##Create a public standard IP address:##
az network public-ip create \
--resource-group $resourcegroup \
--name $ipname \
--sku $sku

##Create Azure load balancer:##
az network lb create \
--resource-group $resourcegroup \
--name $loadbalancer \
--sku $sku \
--public-ip-address $ipname

##Create the health probe:##
az network lb probe create \
--resource-group $resourcegroup \
--lb-name $loadbalancer \
--name $healthprobe \
--protocol $protocol \
--port $port

##Create the load balancer rule:##
az network lb rule create \
--resource-group $resourcegroup \
--lb-name $loadbalancer \
--name $loadbalancerrule \
--protocol $protocol \
--frontend-port $port \
--backend-port $port \
--probe-name $healthprobe

##Create a virtual network:##
az network vnet create \
--resource-group $resourcegroup \
--name $virtualnetwork \
--subnet-name $subnet

##Create a network security group:##
az network nsg create \
--resource-group $resourcegroup \
--name $networksecurityrule

##Create a newtwork security: ##