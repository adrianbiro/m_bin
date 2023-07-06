#!/usr/bin/pwsh
#Requires -Version 6.1
Param(
    [system.io.fileinfo]$file
)
if ((-not $file ) -or -not (Test-Path -LiteralPath $file)) {
    Write-Host("Usage:`n`t{0} <file.md>" -f $MyInvocation.MyCommand.Name)
    exit 1  
}
(ConvertFrom-Markdown -Path $file).Html `
| Out-File -Encoding utf8 -LiteralPath (
    Join-Path -Path $file.DirectoryName -ChildPath ("{0}.html" -f $file.BaseName)
)

