#!/bin/bash

##Automate the process of deleting a role for an existing user.##

##Check if azure is installed##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

username=$1
displayname=$2
domain=$3
userprincipalname=$displayname@$domain
role=$4

##Step One: Login into Azure.##
az login -u $username

##Step Two: Verify that user has admin credentials to continue.##
echo "Verifying for Administrator Credentials. Please wait..."
check=$(az role assignment list  --include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" | grep -E $username)
if [ -z $check ]; then
echo "You must have administrator credentials to use access this functionality" 1>&2
exit 1
fi
echo "User Validated"

##Step Three: Delete the role.##

if [ -z $userprincipalname ]; then
echo "Invalid username. Please provide an existing username." 1>&2
exit 1
elif [ -z $role ]; then
echo "Invalid role." 1>&2
exit 1
fi

echo "Deleting role. Please wait..."
az role assignment delete --assignee $userprincipalname --role $role
echo "Role assigned"