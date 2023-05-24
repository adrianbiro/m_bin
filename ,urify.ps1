#!/usr/bin/pwsh
<#
.SYNOPSIS
    urify
.DESCRIPTION
    URL Encode/Decode
.PARAMETER Strings
    Value from pipeline or as positional and named argument 
.PARAMETER d
    Decode strinng 
.EXAMPLE
    Get-Clipboard | ,urify.ps1
    ,urify.ps1 <uri_string>
#>

Param(
    [Parameter(Mandatory, ValueFromPipeline)]
    [AllowEmptyString()]
    [string]$Strings = $Input, # to make it works from bash
    [switch]$d = $false,
    [switch]$h = $false
)

process {
    if ($h) {
        "Usage:`n`t{0} {1}`n`techo {1} | {0}`n`t{0} -d {1}_to_decode" -f $MyInvocation.MyCommand.Name, "uristring" 
        exit 0
    } 
    if ($d) {
        [System.Web.HttpUtility]::UrlDecode($Strings)
    }
    else {
        [System.Web.HttpUtility]::UrlEncode($Strings)
    }
}