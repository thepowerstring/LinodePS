<#
 .Synopsis
  Returns available Linode types.

 .Description
  This function is a wrapper for Invoke-RestMethod.

 .Parameter linodeep
  Base Linode endpoint URL.

 .Parameter linodeimagesep
  Linode types endpoint URL (built using $linodeep base URL).

 .Example
   # Return list of linode types
   Get-LinodeTypes
#>

function Get-LinodeTypes {
    [CmdletBinding()]
    param(
        $linodeep = 'https://api.linode.com/v4/',
        $linodetypesep = $linodeep + "linode/types/"
    )
    $linodetypes = Invoke-RestMethod -Method GET -Uri $linodetypesep
    Write-Host "$($linodetypes.data.count) total Linode types found."
    $linodetypes.data.id
}
