#!/usr/bin/env pwsh
<#
    .SYNOPSIS
        Convert iso-8859-02 encoding to utf-8 or utf-8-with-bom explicitelly.
            To get all suported encodings run:
            [System.Text.Encoding]::GetEncodings()

    .LINK
        https://github.com/adrianbiro/m_bin

#>

[CmdletBinding()]                                                           
param (
    [Parameter(Mandatory = $True)]
    [ValidateScript(
        { (Test-Path -Path $_ -PathType "Leaf") },
        ErrorMessage = "Specify name of existing input file."
    )]                                                                     
    [Alias("i")][string]$InputFile,
    [Parameter(Mandatory = $False)]
    [Alias("o")][string]$OutputFile,
    [switch]$Utf8WithBom = $False 
    
)
begin {
    if ([string]::IsNullOrEmpty($OutputFile)) {
        # /path/to/foo.csv -> foo.csv -> utf8_foo.csv
        $NewName = "utf8_{0}" -f (Get-ChildItem -Name $InputFile)
        # $PWD/utf8_foo.csv
        $OutputFile = (Join-Path -Path $PWD -ChildPath $NewName)
    }
}

process {
    $OutputFile
    
    [string[]]$Lines = [System.IO.File]::ReadAllLines(
        $InputFile, 
        [System.Text.Encoding]::GetEncoding('iso-8859-2')
    )
    if ($Utf8WithBom) {
        $Lines | Out-File -Encoding utf8BOM -FilePath $OutputFile
        return 
    }
    
    [System.IO.File]::WriteAllLines(
        $OutputFile, 
        $Lines, 
        [System.Text.Encoding]::GetEncoding('utf-8')
    )
}
    
    
end {
    Write-Verbose "Converted file: $OutputFile"
    Write-Verbose "Placed in: $(Resolve-Path $OutputFile)"
}