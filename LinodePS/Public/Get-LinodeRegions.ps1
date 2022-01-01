<#
 .Synopsis
  Returns available Linode regions.

 .Description
  This function is a wrapper for Invoke-RestMethod.

 .Parameter linodeep
  Base Linode endpoint URL.

 .Parameter linoderegionsep
  Linode regions endpoint URL (built using $linodeep base URL).

 .Example
   # Return list of linode images
   Get-LinodeRegions
#>

function Get-LinodeRegions {
    [CmdletBinding()]
    param(
        $linodeep = 'https://api.linode.com/v4/',
        $linoderegionsep = $linodeep + "regions/"
    )
    $linoderegions = Invoke-RestMethod -Method GET -uri $linoderegionsep
    Write-Host "$($linoderegions.data.count) total Linode regions found."
    $linoderegions.data.id
}
