#!/bin/pwsh

Write-Host -NoNewline [string](Get-Date | Select-Object -Property * | ConvertTo-Json -Depth 100 -Compress)
