#!/bin/env pwsh

Param([string]$File)

$Object = ConvertFrom-Json -InputObject (Get-Content -Raw -Path $File) -Depth 99 


function Get-Container {
    Param([string]$Type)
    if ($Type -eq "text/x-moz-place-container") {
        return $true
    }
    return $false
}
function Find-Object {
    Param([System.Object]$Object)
    ForEach-Object -InputObject $Object -Process {
        # Page
        if ( -not (Get-Container -Type $_.children.type) ) {
            foreach ($i in $_.children ) {
                if ($i.url -ne "") {
                    "-[{0}]({1})" -f $i.title, $i.uri
                }
            }
        } #else {
        #  "************"
        #}
    }
} 


Where-Object -InputObject $Object.children -FilterScript {
    $_.title -eq "toolbar"
} | ForEach-Object { 
    Find-Object -Object $_.children  
}
