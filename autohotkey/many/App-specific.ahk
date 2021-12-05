#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Space::^!+1

#IfWinActive, ahk_exe brave.exe
	; Mouse shortcuts for changing tabs
	^XButton1::Send, ^+{Tab}
	^XButton2::Send, ^{Tab}

  !,::Send, ^+{Tab}
  !.::Send, ^{Tab}

	; KB shortcuts for specific tabs
	!1::Send, ^1
	!2::Send, ^2
	!3::Send, ^3
	!4::Send, ^4
	!5::Send, ^5

  ; tab picker
  !e::Send, ^+a

  ; last used tab
  ; !w::Send, ^6
#IfWinActive

#IfWinActive, ahk_class CabinetWClass
	+Backspace::Send !{Up}

;   CapsLock & v::
;     Clipboard =
;     Send, ^c
;     ClipWait, 0.1
;     Clipboard = nvy.exe %Clipboard%
;     Send, !d ^v{Enter}
;     WinWait, ahk_exe nvy.exe
;     if ErrorLevel
;     {
;       ; MsgBox, WinWait timed out.
;       return
;     }
;     else
;       WinActivate, ahk_exe nvy.exe
;       WinMove, ahk_exe nvy.exe,, 188, 33, 1600, 1000
;       WinSet, Style, -0xC00000, A ; toggle titlebar
;       ; WinSet, Style,  -0xC40000 , A ; remove frame and titlebar from current window
;   Return

  F1::
    Clipboard =
    Send, ^c
    ClipWait, 1
    Clipboard = %Clipboard%
  return
#IfWinActive

#IfWinActive, ahk_class #32770 Run
	Tab::Down
#IfWinActive

#IfWinActive, ahk_exe Code.exe
  CapsLock & f::Send, {Esc}^s
  CapsLock & r::Send, ^{PgDn}
  CapsLock & e::Send, ^{Pgup}

  XButton2::Alt
#IfWinActive

#IfWinActive, ahk_exe azuredatastudio.exe
  CapsLock & f::Send, {Esc}^s
  CapsLock & r::Send, ^{PgDn}
  CapsLock & e::Send, ^{Pgup}
#IfWinActive

#IfWinActive, Neovide
  CapsLock & f::
    Send {Esc}
    sleep 2
    Send :
    sleep 2
    Send w
    sleep 2
    Send {enter}
  return
#IfWinActive

#IfWinActive, Nvy
  CapsLock & f::
    Send {Esc}:w{enter}
  return
  !q::
    Send {Esc}:q!
    sleep 2
    Send {enter}
  return
#IfWinActive

#IfWinNotActive, ahk_exe WindowsTerminal.exe
  !BS::Send ^{BS}
#IfWinNotActive

#IfWinActive, ahk_exe WindowsTerminal.exe
  !,::Send, ^+{Tab}
  !.::Send, ^{Tab}
#IfWinActive
