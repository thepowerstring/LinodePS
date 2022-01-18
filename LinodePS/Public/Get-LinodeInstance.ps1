<#
 .Synopsis
  Returns list of Linodes that you can view.

 .Description
  This function is a wrapper for Invoke-RestMethod.

 .Parameter apikey
  Your Linode API key. Should be 64 character alphanumeric sting, looks like 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

 .Parameter linodeep
  Base Linode endpoint URL.

 .Parameter linodeimagesep
  Linode images endpoint URL (built using $linodeep base URL).

 .Example
   # Return list of linode images
   Get-LinodeInstance -apikey <your_api_key>
#>

function Get-LinodeInstance {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "Your Linode api key goes here.")]
        [ValidateNotNullOrEmpty()]
        $apikey,
        $linodeep = 'https://api.linode.com/v4/',
        $linodeinstancesep = $linodeep + "linode/instances/"
    )
    $header = @{
        Authorization = "Bearer $apikey"
    }
    $instances = Invoke-RestMethod -Method GET -uri $linodeinstancesep -Headers $header -ContentType 'application/json'
    $instances.data | Select-Object id, label, status, created
}
