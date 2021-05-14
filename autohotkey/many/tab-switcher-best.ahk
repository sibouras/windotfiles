#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


RAlt & v::ToggleWindowVisibility("ahk_exe neovide.exe")
RAlt & e::ToggleWindowVisibility("ahk_class CabinetWClass")
RAlt & f::ToggleWindowVisibility("ahk_exe mpv.exe")
RAlt & d::ToggleWindowVisibility("ahk_exe code.exe")
RAlt & s::ToggleWindowVisibility("ahk_exe brave.exe")
RAlt & r::ToggleWindowVisibility("ahk_exe alacritty.exe")
RAlt & t::ToggleWindowVisibility("ahk_exe WindowsTerminal.exe")

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