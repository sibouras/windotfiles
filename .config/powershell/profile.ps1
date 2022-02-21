$scripts = "$HOME\.config\powershell\Scripts"
$env:path += ";$scripts"
$env:EDITOR = "nvim"
$env:PAGER = "bat"

Set-Alias l lsd
Set-Alias v nvim
Set-Alias grep findstr

function ll {
  lsd -l @args
}

function cpath {
  Get-Location | Set-Clipboard
}

function profile {
  nvim "$HOME\.config\powershell\profile.ps1"
}

function br {
  $TempFile = New-TemporaryFile
  broot.exe --outcmd $TempFile $Args

  if (!$?)
  {
    Remove-Item -Force $TempFile
    return $LASTEXITCODE
  }

  $CommandToExecute = Get-Content $TempFile
  Remove-Item -Force $TempFile
  Invoke-Expression $CommandToExecute
}

function winconfig {
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME @args
}

function dotfiles {
  lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME
}

function gst {
  git status @args
}

function gss {
  git status -s
}

function gloo {
  git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short @args
}

function ga {
  git add @args
}

function getProcess {
  Get-Process | Group-Object -Property ProcessName |
  Select-Object Count, Name,
  @{
    Name       = 'Memory usage(Total in MB)';
    Expression = { '{0:N2}' -f (($_.Group |
          Measure-Object WorkingSet -Sum).Sum / 1MB) }
  }
}

# Get-MyProcess brave, neovide, explorer
Function Get-MyProcess {
  [cmdletbinding()]
  Param([string[]]$Name)

  $Name | foreach-object {
    Get-Process -name $_ -PipelineVariable pv |
    Measure-Object Workingset -sum -average |
    Select-object @{Name = "Name"; Expression = { $pv.name } },
    Count,
    @{Name = "SumMB"; Expression = { [math]::round($_.Sum / 1MB, 2) } },
    @{Name = "AvgMB"; Expression = { [math]::round($_.Average / 1MB, 2) } }
  }
}

Function fs($path) {
  Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue |
  Measure-Object -Property Length -Sum |
  Select-Object Count, @{Name = "Size(MB)"; Expression = { '{0:N2}' -f ($_.Sum / 1MB) } }
}

Function whichh ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
  })

# adds 400ms to startup time
# Import-Module -Name Terminal-Icons

# dahlbyk/posh-git config (adds 300ms to startup)
# Import-Module posh-git

Set-PSReadLineOption -PredictionSource History

# PSReadLine config. from https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/SamplePSReadLineProfile.ps1
Set-PSReadLineOption -EditMode Emacs

# In Emacs mode - Tab acts like in bash, but the Windows style completion
# is still useful sometimes, so bind some keys so we can do both
Set-PSReadLineKeyHandler -Key Ctrl+q -Function TabCompleteNext
Set-PSReadLineKeyHandler -Key Ctrl+Q -Function TabCompletePrevious

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
Set-PSReadLineKeyHandler -Key Ctrl+C -Function Copy
Set-PSReadLineKeyHandler -Key Ctrl+v -Function Paste

# ctrl+backspace to kill word
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function BackwardKillWord

# swap tab and ctrl+space
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -Function Complete

# This key handler shows the entire or filtered history using Out-GridView. The
# typed text is used as the substring pattern for filtering. A selected command
# is inserted to the command line without invoking. Multiple command selection
# is supported, e.g. selected by Ctrl + Click.
Set-PSReadLineKeyHandler -Key F7 `
  -BriefDescription History `
  -LongDescription 'Show command history' `
  -ScriptBlock {
  $pattern = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
  if ($pattern) {
    $pattern = [regex]::Escape($pattern)
  }

  $history = [System.Collections.ArrayList]@(
    $last = ''
    $lines = ''
    foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath)) {
      if ($line.EndsWith('`')) {
        $line = $line.Substring(0, $line.Length - 1)
        $lines = if ($lines) {
          "$lines`n$line"
        }
        else {
          $line
        }
        continue
      }

      if ($lines) {
        $line = "$lines`n$line"
        $lines = ''
      }

      if (($line -cne $last) -and (!$pattern -or ($line -match $pattern))) {
        $last = $line
        $line
      }
    }
  )
  $history.Reverse()

  $command = $history | Out-GridView -Title History -PassThru
  if ($command) {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
  }
}

# Ctrl+Shift+j then type a key to mark the current directory. Ctrj+j then the
# same key will change back to that directory without needing to type cd and
# won't change the command line.
$global:PSReadLineMarks = @{}

Set-PSReadLineKeyHandler -Key Ctrl+J `
  -BriefDescription MarkDirectory `
  -LongDescription "Mark the current directory" `
  -ScriptBlock {
  param($key, $arg)

  $key = [Console]::ReadKey($true)
  $global:PSReadLineMarks[$key.KeyChar] = $pwd
}

Set-PSReadLineKeyHandler -Key Ctrl+j `
  -BriefDescription JumpDirectory `
  -LongDescription "Goto the marked directory" `
  -ScriptBlock {
  param($key, $arg)

  $key = [Console]::ReadKey()
  $dir = $global:PSReadLineMarks[$key.KeyChar]
  if ($dir) {
    Set-Location $dir
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }
}

Set-PSReadLineKeyHandler -Key Alt+i `
  -BriefDescription ShowDirectoryMarks `
  -LongDescription "Show the currently marked directories" `
  -ScriptBlock {
  param($key, $arg)

  $global:PSReadLineMarks.GetEnumerator() | ForEach-Object {
    [PSCustomObject]@{Key = $_.Key; Dir = $_.Value } } |
  Format-Table -AutoSize | Out-Host

  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

# Sometimes you want to get a property of invoke a member on what you've
# entered so far but you need parens to do that.  This binding will help by
# putting parens around the current selection, or if nothing is selected, the
# whole line.
Set-PSReadLineKeyHandler -Key 'Alt+(' `
  -BriefDescription ParenthesizeSelection `
  -LongDescription "Put parenthesis around the selection or entire line and move the cursor to after the closing parenthesis" `
  -ScriptBlock {
  param($key, $arg)

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($selectionStart -ne -1) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, '(' + $line.SubString($selectionStart, $selectionLength) + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
  }
}

# Each time you press Alt+', this key handler will change the token under or
# before the cursor.  It will cycle through single quotes, double quotes, or no
# quotes each time it is invoked.
Set-PSReadLineKeyHandler -Key "Alt+'" `
  -BriefDescription ToggleQuoteArgument `
  -LongDescription "Toggle quotes on the argument under the cursor" `
  -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $tokens = $null
  $errors = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

  $tokenToChange = $null
  foreach ($token in $tokens) {
    $extent = $token.Extent
    if ($extent.StartOffset -le $cursor -and $extent.EndOffset -ge $cursor) {
      $tokenToChange = $token

      # If the cursor is at the end (it's really 1 past the end) of the
      # previous token, we only want to change the previous token if there is
      # no token under the cursor
      if ($extent.EndOffset -eq $cursor -and $foreach.MoveNext()) {
        $nextToken = $foreach.Current
        if ($nextToken.Extent.StartOffset -eq $cursor) {
          $tokenToChange = $nextToken
        }
      }
      break
    }
  }

  if ($tokenToChange -ne $null) {
    $extent = $tokenToChange.Extent
    $tokenText = $extent.Text
    if ($tokenText[0] -eq '"' -and $tokenText[-1] -eq '"') {
      # Switch to no quotes
      $replacement = $tokenText.Substring(1, $tokenText.Length - 2)
    }
    elseif ($tokenText[0] -eq "'" -and $tokenText[-1] -eq "'") {
      # Switch to double quotes
      $replacement = '"' + $tokenText.Substring(1, $tokenText.Length - 2) + '"'
    }
    else {
      # Add single quotes
      $replacement = "'" + $tokenText + "'"
    }

    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
      $extent.StartOffset,
      $tokenText.Length,
      $replacement)
  }
}

# `ForwardChar` accepts the entire suggestion text when the cursor is at the
# end of the line. This custom binding makes `RightArrow` behave similarly -
# accepting the next word instead of the entire suggestion text.
Set-PSReadLineKeyHandler -Key Alt+w `
  -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
  -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -lt $line.Length) {
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
  }
}

# Cycle through arguments on current line and select the text. This makes it
# easier to quickly change the argument if re-running a previously run command
# from the history or if using a psreadline predictor. You can also use a digit
# argument to specify which argument you want to select, i.e. Alt+1, Alt+a
# selects the first argument on the command line.
Set-PSReadLineKeyHandler -Key Alt+e `
  -BriefDescription SelectCommandArguments `
  -LongDescription "Set current selection to next command argument in the command line. Use of digit argument selects argument by position" `
  -ScriptBlock {
  param($key, $arg)

  $ast = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)

  $asts = $ast.FindAll( {
      $args[0] -is [System.Management.Automation.Language.ExpressionAst] -and
      $args[0].Parent -is [System.Management.Automation.Language.CommandAst] -and
      $args[0].Extent.StartOffset -ne $args[0].Parent.Extent.StartOffset
    }, $true)

  if ($asts.Count -eq 0) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
    return
  }

  $nextAst = $null

  if ($null -ne $arg) {
    $nextAst = $asts[$arg - 1]
  }
  else {
    foreach ($ast in $asts) {
      if ($ast.Extent.StartOffset -ge $cursor) {
        $nextAst = $ast
        break
      }
    }

    if ($null -eq $nextAst) {
      $nextAst = $asts[0]
    }
  }

  $startOffsetAdjustment = 0
  $endOffsetAdjustment = 0

  if ($nextAst -is [System.Management.Automation.Language.StringConstantExpressionAst] -and
    $nextAst.StringConstantType -ne [System.Management.Automation.Language.StringConstantType]::BareWord) {
    $startOffsetAdjustment = 1
    $endOffsetAdjustment = 2
  }

  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($nextAst.Extent.StartOffset + $startOffsetAdjustment)
  [Microsoft.PowerShell.PSConsoleReadLine]::SetMark($null, $null)
  [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar($null, ($nextAst.Extent.EndOffset - $nextAst.Extent.StartOffset) - $endOffsetAdjustment)
}

# Sometimes you enter a command but realize you forgot to do something else first.
# This binding will let you save that command in the history so you can recall it,
# but it doesn't actually execute.  It also clears the line with RevertLine so the
# undo stack is reset - though redo will still reconstruct the command line.
Set-PSReadLineKeyHandler -Key Alt+n `
  -BriefDescription SaveInHistory `
  -LongDescription "Save current line in history but do not execute" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

# Insert text from the clipboard as a here string
Set-PSReadLineKeyHandler -Key Ctrl+V `
  -BriefDescription PasteAsHereString `
  -LongDescription "Paste the clipboard text as a here string" `
  -ScriptBlock {
  param($key, $arg)

  Add-Type -Assembly PresentationCore
  if ([System.Windows.Clipboard]::ContainsText()) {
    # Get clipboard text - remove trailing spaces, convert \r\n to \n, and remove the final \n.
    $text = ([System.Windows.Clipboard]::GetText() -replace "\p{Zs}*`r?`n", "`n").TrimEnd()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("@'`n$text`n'@")
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
  }
}

### Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

### fzf config
$env:FZF_DEFAULT_COMMAND = 'fd --type f'
$env:FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND"
$env:FZF_ALT_C_COMMAND = "fd --type d"

### PSFzf config: https://github.com/kelleyma49/PSFzf
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
# adds 300 ms to startup time
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-Alias -Name fe -Value Invoke-FuzzyEdit
Set-Alias -Name fh -Value Invoke-FuzzyHistory
Set-Alias -Name fk -Value Invoke-FuzzyKillProcess


### starship config
# Usage: Add 'Invoke-Expression (&starship init powershell)' to the end of your
# PowerShell $PROFILE. Prerequisites: A Powerline font installed and enabled in
# your terminal. 'starship' suggests installing 'extras/vcredist2019'.
Invoke-Expression (&starship init powershell)

