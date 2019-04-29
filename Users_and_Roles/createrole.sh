#!/bin/bash

##Automate the process of creating/assinging a role for an existing user.##

##Check if azure is installed##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

##Parameters:##
read -p "Enter the a login username: " username
read -p "Enter the username of the user you want to update: " displayname
read -p "Enter the domain of the username: " domain
read -p "Enter the role that you want to create/assing: " role
userprincipalname=$displayname@$domain

##Step One: Login into Azure.##
az login -u $username

##Step Two: Verify that user has admin credentials to continue.##
echo "Verifying for Administrator Credentials. Please wait..."

check=$(az role assignment list  \
--include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" \
| grep -E $username)

if [ -z $check ]; then
echo "You must have administrator credentials to use access this functionality" 1>&2
exit 1
fi

echo "User Validated"

##Step Three: Creating/Assinging the role.##
if [ -z $userprincipalname ]; then
echo "Invalid username. Please provide an existing username." 1>&2
exit 1
elif [ -z $role ]; then
echo "Invalid role." 1>&2
exit 1
fi

echo "Deleting role. Please wait..."

az role assignment create \
--assignee $userprincipalname \
--role $role

echo "Role created/assinged."