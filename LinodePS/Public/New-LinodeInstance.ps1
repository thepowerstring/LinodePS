<#
 .Synopsis
  Creates new Linode Instance.

 .Description
  This function creates a new Linode Instance (Warning! You will be charged by Linode!).

 .Parameter apikey
  Your Linode API key. Should be 64 character alphanumeric sting, looks like 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

 .Parameter image
  Name of the image that you want to deploy on your new Linode. Ex. 'linode/arch'. Use get-linodeimates to return list of availbla images.

 .Parameter type
  Name of the Linode type that you want to create. Ex. 'g6-nanode-1'. Use get-linodetypes to return list of availbable types.

 .Parameter region
  Name of region that you want to use for creating Linode. Ex. 'us-east'. Use get-linoderegions to return list of available regions.

 .Parameter rootpassword
  Value of root password for new Linode. Ex. 'MySuperSecretPassword'. WARNING: Plain text password used for example only. Please follow secret management best practices.

 .Parameter label
  Label for new Linode. Ex. 'Prod_01'. Must include only letters, numbers, and underscores.

 .Example
   # Create New Linode Instance
   New-LinodeInstance -apikey <your_api_key> -image 'linode/arch' -type 'g6-nanode-1' -region 'us-east' -rootpw <your_root_password> -label <your_new_label>
#>

function New-LinodeInstance {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "Your Linode api key goes here.")]
        [ValidateNotNullOrEmpty()]
        $apikey,
        $linode = 'https://api.linode.com/v4/',
        $linodeinstancesep = $linode + "linode/instances",
        [Parameter(Mandatory = $true, HelpMessage = "Name of image goes here. Ex. 'linode/arch'")]
        $image,
        [Parameter(Mandatory = $true, HelpMessage = "Name of Linode type goes here. Ex. 'g6-nanode-1'")]
        $type,
        [Parameter(Mandatory = $true, HelpMessage = "Name of region goes here. Ex. 'us-east'")]
        $region,
        [Parameter(Mandatory = $true, HelpMessage = "Value of root password for new Linode goes here. Ex. 'MySuperSecretPassword'")]
        $rootpw,
        [Parameter(Mandatory = $true, HelpMessage = "Name of label for new Linode goes here. Ex. 'Prod01")]
        $label
    )
    Process {
        #begin region build query header
        $headerhashtable = @{
            Authorization = "Bearer $apikey"
            #"Content-type" = 'application\json'
        }
        #end region build query header
        #begin region build query body
        $bodyhashtable = @{
            type      = $type
            region    = $region
            image     = $image
            root_pass = $rootpw
            label     = $label
        }
        #end region build query body
        Invoke-RestMethod -Method POST -Uri $linodeinstancesep -header $headerhashtable -body ($bodyhashtable | ConvertTo-Json) -ContentType 'application/json'
    }
}
