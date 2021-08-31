#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; RAlt & v::ToggleWindowVisibility("ahk_exe neovide.exe")
RAlt & e::ToggleWindowVisibility("ahk_class CabinetWClass")
RAlt & f::ToggleWindowVisibility("ahk_exe mpv.exe")
RAlt & d::ToggleWindowVisibility("ahk_exe code.exe")
RAlt & s::ToggleWindowVisibility("ahk_exe brave.exe")
RAlt & r::ToggleWindowVisibility("Alacritty")
RAlt & w::ToggleWindowVisibility("ahk_exe WindowsTerminal.exe")

ToggleWindowVisibility(windowClass) {
	IfWinExist, %windowClass%
	{
		IfWinActive, %windowClass%
      WinMinimize, %windowClass%
		else
      WinActivate, %windowClass%
	}
  ; else {
  ;   word_array := StrSplit(windowClass, A_Space, "") ; Omits periods.
  ;   MsgBox % word_array[2] " is not open!"
  ; }
}

RAlt & v::
nvy = ahk_exe nvy.exe
IfWinExist, %nvy%
{
  IfWinActive, %nvy%
    WinMinimize, %nvy%
  else
    WinActivate, %nvy%
}
else {
    Run, "C:\tools\nvy\Nvy.exe"
    WinWaitActive, %nvy%,, 0.5
    if ErrorLevel
    {
      ; MsgBox, WinWait timed out.
      return
    }
    else
      WinMove, %nvy%,, 188, 33, 1600, 1000
      WinSet, Style, -0xC00000, A ; toggle titlebar
}
return

RAlt & t::
IfWinExist, Neovide
{
  IfWinActive, Neovide
    WinMinimize, Neovide
  else
    WinActivate, Neovide
}
else {
    Run, neovide.exe
    WinWaitActive, Neovide,, 2
    if ErrorLevel
    {
      MsgBox, WinWait timed out.
      return
    }
    else
      WinMove, Neovide,, 188, 40, 1600, 990
      WinSet, Style, -0xC00000, A ; toggle titlebar
      ; WinSet, Style, -0xC40000, A ; remove frame and titlebar from current window
}
return

; minimize active window and restore it
RAlt & c::
IfWinExist, ahk_id %lastWindow%
{
 WinGet, WinState, MinMax, ahk_id %lastWindow%
 If WinState = -1
   WinActivate
 else
   WinMinimize
 lastWindow:=  ; remove this line if you want minimize/toggle only one window
}
else
{
 lastWindow:= WinExist("A")
 WinMinimize, ahk_id %lastWindow%
}
return
