Add-Type -AssemblyName System.Windows.Forms
$outstring = "No selection"
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.initialDirectory = "MyComputer"
$dialog.filter = "All Files (*.*)|*.*"
$response = $dialog.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))
if ($dialog.Filename) { $outstring = Split-Path $dialog.Filename -leaf }
Write-Host -NoNewLine $outstring
