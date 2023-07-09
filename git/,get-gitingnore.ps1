#!/usr/bin/pwsh
<#
    .SYNOPSIS
        Print to stdin .gitignore for specified languages.
    
    .LINK
        https://github.com/adrianbiro/m_bin
        https://github.com/adrianbiro/winbin
#>

if (-not $args) {
    "Usage:`n`t{0} python terraform" -f $MyInvocation.MyCommand.Name
    exit 1 
}
try {
    # bkp url https://github.com/adrianbiro/gitignore
    invoke-restmethod -Method "GET" -uri "https://www.gitignore.io/api/$(([string[]] $args) -join ",")"
}
catch {
    "Not valid names:`n`t$args"
    exit 1
}
exit 0