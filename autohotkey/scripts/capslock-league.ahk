#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, Force

SetTitleMatchMode,2 ;sets title match mode to partial match
DetectHiddenWindows,on ;allow detecting hidden windows

; backslash to avoid any other matching window (e.g. a text file named 'Test Script 2.ahk - AutoHotkey.txt')
many := "\many.ahk - AutoHotkey"
hide_mouse_cursor := "\hide-mouse-cursor.ahk - AutoHotkey"
show_time := "\show-time.ahk - AutoHotkey"

; WinGetTitle, Var, %selectedScript%
; msgbox % Var

; ahk_class AutoHotkey to close AHK scripts only
WinClose, %many% ahk_class AutoHotkey
WinClose, %hide_mouse_cursor% ahk_class AutoHotkey
WinClose, %show_time% ahk_class AutoHotkey

XButton1::Ctrl
CapsLock::Shift
!;::CapsLock
9:: Send, {BS}
+9:: Send, ^{BS}

!F1:: Run nircmd.exe mutesysvolume 1 "external microphone" ; Mute
!F2:: Run nircmd.exe mutesysvolume 0 "external microphone" ; Unmute
; !F4:: Run nircmd.exe mutesysvolume 2 "external microphone"  ; Toggle

#1::
  firefox = ahk_class MozillaWindowClass
  if not WinActive(firefox) {
    WinActivate, %firefox%
  }
return

#2::
  league = ahk_exe League of Legends.exe
  client = ahk_exe LeagueClientUx.exe
  if WinExist(client) {
    if not WinActive(client) {
      WinActivate, %client%
    }
  } else if not WinActive(league) {
    WinActivate, %league%
  }
return

; enter::
;   SetCapsLockState off
;   send, {enter}
; return
;
; +enter::
;   SetCapsLockState off
;   send, +{enter}
; return

; NumpadEnter::
;   SetCapsLockState off
;   send, {enter}
; return
;
; +NumpadEnter::
;   SetCapsLockState off
;   send, +{enter}
; return

!+c::
  EnvGet, vUserProfile, USERPROFILE
  Run, %vUserProfile%\autohotkey\many\many.ahk
  Run, %vUserProfile%\autohotkey\scripts\hide-mouse-cursor.ahk
  Run, %vUserProfile%\autohotkey\NotifyClass-NotifyCreator\show-time.ahk
ExitApp
return
