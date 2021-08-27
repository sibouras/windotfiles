#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include %A_ScriptDir%\make-capslock-great.ahk
; #Include %A_ScriptDir%\drag-windows.ahk
#Include %A_ScriptDir%\AppsKey.ahk
#Include %A_ScriptDir%\Hotstrings.ahk
#Include %A_ScriptDir%\App-specific.ahk
#Include %A_ScriptDir%\tab-switcher-best.ahk
#Include %A_ScriptDir%\restore-maximize.ahk
#Include %A_ScriptDir%\window-moving-vim.ahk

!+r::reload
