#!/usr/bin/pwsh
Param(
    [string] $folder = (Get-Location),
    [int] $seconds = 30
)
do {
    $result = "{0:N3} MB" -f ((Get-ChildItem $folder -Recurse | Measure-Object -Property Size -Sum -ErrorAction Stop).Sum / 1MB)
    $result1 = "{0:N3} GB" -f ((Get-ChildItem $folder -Recurse | Measure-Object -Property Size -Sum -ErrorAction Stop).Sum / 1GB)
    $hour = (Get-Date).ToString()
    
    write-host $hour -ForegroundColor Yellow
    write-host $result -ForegroundColor Green
    write-host $result1 -ForegroundColor Cyan
    
    start-sleep -Seconds ([TimeSpan]::FromSeconds($seconds).TotalSeconds)
}until([bool]$false)