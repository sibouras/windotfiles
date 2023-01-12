<#
.SYNOPSIS
	Lists the folder content 
.DESCRIPTION
	This script lists the directory content formatted in columns.
.PARAMETER SearchPattern
	Specifies the search pattern, "*" by default (means anything) 
.EXAMPLE
	PS> ./list-folder C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$SearchPattern = "*")

function ListFolder {
  param([string]$SearchPattern)
  $Items = get-childItem -path "$SearchPattern"
  foreach ($Item in $Items) {
    $Name = $Item.Name
    if ($Name[0] -eq '.') { continue } # hidden file/dir
    if ($Item.Mode -like "d*") {
      $Icon = "📂" 
    }
    elseif ($Name -like "*.iso") {
      $Icon = "📀"
    }
    elseif ($Name -like "*.mp3") {
      $Icon = "🎵"
    }
    elseif ($Name -like "*.epub") {
      $Icon = "📓"
    }
    else { $Icon = "📄" }
    new-object PSObject -Property @{ Name = "$Icon$Name" }
  }
}

try {
  ListFolder $SearchPattern | format-wide -autoSize
  exit 0 # success
}
catch {
  "⚠ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
  exit 1
}
