<#
 .Synopsis
  Deletes a Linode.

 .Description
  This function is a wrapper for Invoke-RestMethod.

 .Parameter apikey
  Your Linode API key. Should be 64 character alphanumeric sting, looks like 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

 .Parameter linodeep
  Base Linode endpoint URL.

 .Parameter linodeimagesep
  Linode images endpoint URL (built using $linodeep base URL).

.Parameter isntanceid
  The ID of Linode instance you want to destroy. Ex. '12345678'

 .Example
   # Return list of linode images
   Remove-LinodeInstance -apikey <your_api_key> -instanceid <ID_of_instance>
#>

function Remove-LinodeInstance {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "Your Linode api key goes here.")]
        [ValidateNotNullOrEmpty()]
        $apikey,
        $linodeep = 'https://api.linode.com/v4/',
        $linodeinstancesep = $linodeep + "linode/instances/",
        [Parameter(Mandatory = $true, HelpMessage = "Enter ID of isntance that you want to destroy. Ex. '12345678'")]
        [ValidateNotNullOrEmpty()]
        $instanceid
    )
    $header = @{
        Authorization = "Bearer $apikey"
    }
    $result = Invoke-RestMethod -Method DELETE -Uri ($linodeinstancesep + $instanceid) -Headers $header -ContentType 'application/json'
    $result
}
