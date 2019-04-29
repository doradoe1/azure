#!/bin/bash

##Automate the process of creating a user.##

##Check if azure is installed##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

##Parameters:##
read -p "Enter the a login username: " username
read -p "Enter the username of the user you want to update: " displayname
read -p "Enter the domain of the username: " domain
read -p "Enter the subscription name or id: " subscription
userprincipalname=$displayname@$domain

##Step One: Login into Azure.##
az login -u $username

##Step Two: Verify that user has admin credentials to continue.##
echo "Verifying for Administrator Credentials. Please wait..."

verifyadmin=$(az role assignment list \
--include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" \
| grep -E $username)

if [ -z $verifyadmin ]; then
echo "You must have administrator credentials to use access this functionality" 1>&2
exit 1
fi

echo "User Validated"

##Step Three: Create the user.##

verifyuser=$(az ad user list \
--query [].userprincipalname \
| grep -E $userprincipalname)

if [ -n $verifyuser ]; then
echo "User being created. Please wait..."
az ad user create \
--display-name $displayname \
--password Revature2019 \
--user-principal-name $userprincipalname \
--subscription $subscription \
--force-change-password-next-login true
exit 0
fi

echo "User created succesfully."