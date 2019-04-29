##Check if azure is installed:##
if [ -z $(which az) ]; then
echo "Azure missing. Install azure. Run brew install azure-cli and try again" 1>&2
exit 1
fi

##Aditional Parameters:##
read -p "Enter the data disk sources: " dds
read -p "Enter a location for resource group: " location
read -p "Enter the os disk caching (None, ReadOnly, or ReadWrite): " odc
read -p "Enter the os type (Linux or Windows): " ostype
read -p "Enter the size: " size

-data-disk-sources $dds \
--location $location \
--os-disk-caching $odc \
--os-type $ostype \
--size $size