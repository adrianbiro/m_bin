#!/usr/bin/pwsh
Param(
    [int] $Length = 14
)
[string[]] $ASCII = (33..126 | ForEach-Object { [char]$_ })  

Write-Host ( -Join (Get-Random -InputObject $ASCII -Count $Length), [string]::Empty).Trim()
