#!/usr/bin/pwsh
Param(
    [int] $Length = 14
)
#[string[]] $ASCII = (33..126 | ForEach-Object { [char]$_ })  
[string[]] $SAFESTRING = "0123456789ABCDEFGHJKMNPQRSTVWXYZ" -split ""
#Write-Host ( -Join (Get-Random -InputObject $ASCII -Count $Length), [string]::Empty).Trim()
Write-Host( 
    -join (1..$Length | ForEach-Object { $SAFESTRING[[System.Security.Cryptography.RandomNumberGenerator]::GetInt32($SAFESTRING.Length)] })
)

#( -Join (Get-Random -InputObject  (65..122 | ForEach-Object { if (-not (91..96 -contains $_)){[char]$_ }}) -Count 30), [string]::Empty).Trim() | Set-Clipboard; Get-Clipboard
