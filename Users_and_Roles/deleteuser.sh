#!/bin/bash

##Automate the process of creating a user.##

##Check if azure is installed##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

username=$1
displayname=$2
domain=$3
userprincipalname=$displayname@$domain 

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
##Step Three: Delete a non-admin user.##

##Administration credentials checkpoint. Will not procced if userprincipalname##
##belongs to an account administrator.##

admincheck=$(az role assignment list \
--include-classic-administrators \
--query "[?id=='NA(classic admins)'].principalName" | grep -E $userprincipalname)
if ! [ -z $admincheck ]; then
echo "The user you are attempting to delete is an administrator." \
"You do not have the permissions nessesary to delete administrators" 1>&2
exit 1
fi

##Verifying the existence of the user and deleting user from Azure Cloud##

user=$(az ad user list --query [].userPrincipalName | grep -E $userprincipalname)
if [ -z $user ]; then
echo "Invalid user. Please enter an existing user with non-administrator credentials." 1>&2
exit 1
else
echo "User exists. Deleting User. Please wait..."
az ad user delete --upn-or-object-id $userprincipalname
exit 0
fi
echo 'User deleted'