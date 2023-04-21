#!/usr/bin/pwsh
<#
.SYNOPSIS
    nonprint
.DESCRIPTION
    replace nonprintable characters with empty string
.PARAMETER Strings
    Value from pipeline or as positional and named argument 
.EXAMPLE
    Get-Clipboard | ,nonprint.ps1
#>

Param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [AllowEmptyString()]
    [string]$Strings = $Input  # to make it works from bash
)
    
process {
    [Regex]::Replace($Strings, '@"\p{C}+"', [string]::Empty)
}
