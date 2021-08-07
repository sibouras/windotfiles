#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Space::^!+1

#IfWinActive, ahk_exe brave.exe
	; Mouse shortcuts for changing tabs
	^XButton1::Send, ^+{Tab}
	^XButton2::Send, ^{Tab}

	; KB shortcuts for specific tabs
	!1::Send, ^1
	!2::Send, ^2
	!3::Send, ^3
	!4::Send, ^4
	!5::Send, ^5

  ; tab picker
  !w::Send, ^+a

  ; last used tab
  !e::Send, ^6
#IfWinActive

#IfWinActive, ahk_class CabinetWClass
	+Backspace::Send !{Up}

  CapsLock & v::
    Clipboard =
    Send, ^c
    ClipWait, 0.1
    Clipboard = neovide.exe %Clipboard%
    Send, !d ^v{Enter}
    WinWaitActive, ahk_exe neovide.exe,, 2
    if ErrorLevel
    {
      MsgBox, WinWait timed out.
      return
    }
    else
      WinMove, ahk_exe neovide.exe,, 188, 40, 1600, 990
      WinSet, Style,  -0xC40000 , A ; remove frame and titlebar from current window
  Return

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
#IfWinActive
