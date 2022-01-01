<#
 .Synopsis
  Returns available Linode images.

 .Description
  This function is a wrapper for Invoke-RestMethod.

 .Parameter linodeep
  Base Linode endpoint URL.

 .Parameter linodeimagesep
  Linode images endpoint URL (built using $linodeep base URL).

 .Example
   # Return list of linode images
   Get-LinodeImages
#>

function Get-LinodeImages {
    [CmdletBinding()]
    param(
        $linodeep = 'https://api.linode.com/v4/',
        $linodeimagesep = $linodeep + "images/"
    )
    $linodeimages = Invoke-RestMethod -Method GET -uri $linodeimagesep
    Write-Host "$($linodeimages.data.count) total Linode images found."
    $linodeimages.data.id
}
