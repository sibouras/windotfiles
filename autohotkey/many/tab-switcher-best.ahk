#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Alt & j::AltTab
Alt & k::ShiftAltTab

RAlt & v::ToggleWindowVisibility("ahk_exe nvy.exe")
; RAlt & e::ToggleWindowVisibility("ahk_class CabinetWClass")
RAlt & e::ToggleWindowVisibility("ahk_exe fman.exe")
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

RAlt & b::
nvy = ahk_exe nvy.exe
Loop
{
  WinWait, %nvy%
    WinMove, %nvy%,, 188, 33, 1600, 1000
    WinSet, Style, -0xC00000, A ; toggle titlebar
  WinWaitClose
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
    WinWait, Neovide,, 1
    if ErrorLevel
    {
      MsgBox, WinWait timed out.
      return
    }
    else
      WinActivate,Neovide
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

; run everytime nvy opens
; nvy = ahk_exe nvy.exe
; Loop
; {
  ; WinWait, %nvy%
    ; WinActivate %nvy%
    ; WinMove, %nvy%,, 188, 33, 1600, 1000
    ; WinSet, Style, -0xC00000, A ; toggle titlebar
  ; WinWaitClose
; }

