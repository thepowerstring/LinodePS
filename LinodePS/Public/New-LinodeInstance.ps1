<#
 .Synopsis
  Creates new Linode Instance.

 .Description
  This function creates a new Linode Instance (Warning! You will be charged by Linode!).

 .Parameter apikey
  Your Linode API key.

 .Parameter image
  Uses variable $linodeimage defined prior to running this cmdlet.

 .Parameter type
  Uses variable $linodetype defined prior to running this cmdlet.

 .Parameter region
  Uses variable $linoderegion defined prior to running this cmdlet.

 .Parameter rootpassword
  Uses variable $rootpassword defined prior to running this cmdlet. Used for setting root password on Linode Instance.

 .Parameter label
  Uses variable $linodelabel defined prior to running this cmdlet. Used for assigning label to new Linode Instance.

 .Example
   # Create New Linode Instance
   New-LinodeInstance
#>

function New-LinodeInstance {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $apikey,
        $linode = 'https://api.linode.com/v4/',
        $linodeinstancesep = $linode + "linode/instances",
        $image = $linodeimage,
        $type = $linodetype,
        $region = $linoderegion,
        $rootpw = $rootpassword,
        $label = $linodelabel
    )
    #begin region build query header
    $headerhashtable = @{
        Authorization  = "Bearer $apikey"
        "Content-type" = 'application\json'
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
    Invoke-RestMethod -Method POST -Uri $linodeinstancesep -header (ConvertTo-Json $headerhashtable) -body (ConvertTo-Json $bodyhashtable)
}
