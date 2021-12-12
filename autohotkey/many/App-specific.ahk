#If WinActive("ahk_exe brave.exe") || WinActive("ahk_exe msedge.exe")
{
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
}
#IfWinActive

#IfWinActive, ahk_class CabinetWClass
  +Backspace::Send !{Up}

  !,::Send, ^+{Tab}
  !.::Send, ^{Tab}

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
