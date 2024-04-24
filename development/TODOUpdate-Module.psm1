#!/usr/bin/env pwsh


Function Update-Module {                                                   
    [CmdletBinding()]                                                           
    param (
        [Parameter(Mandatory = $True)]
        [ValidateScript(
            { (Test-Path -Path $_ -PathType "Leaf") -and ($_.EndsWith(".psm1")  ) },
            ErrorMessage = "Specify name of existiong file."
        )]                                                                     
        [Alias("mod")][string]$PowershellModule                            
    )        
    Remove-Module (Get-ChildItem $PowershellModule).BaseName -ErrorAction "SilentlyContinue"
    Import-Module $PowershellModule

}                                                                               
