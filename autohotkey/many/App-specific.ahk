!q::Send, !{f4}
!9::ControlClick,, A,, WheelUp
!0::ControlClick,, A,, WheelDown

#If WinActive("ahk_exe brave.exe") || WinActive("ahk_exe msedge.exe")
{
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

  ; No single alt
  Alt::KeyWait Alt
}


#If WinActive("ahk_exe firefox.exe")
{
  !,::Send, ^{PgUp}
  !.::Send, ^{PgDn}
  !+,::Send, ^+{PgUp}
  !+.::Send, ^+{PgDn}
  !w::Send, ^{Tab}

  ; KB shortcuts for specific tabs
  !1::Send, ^1
  !2::Send, ^2
  !3::Send, ^3
  !4::Send, ^4
  !5::Send, ^5
}

#IfWinActive, ahk_class CabinetWClass
  ^BS::Send ^+{Left}{del}
  ^u:: Send +{home}{del}

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
  !s::Send, {Esc}^s
#IfWinActive

#IfWinActive, ahk_exe nvy.exe
  ^BS::Send, ^{w}
  ^i::Send, !^+{F6}
  ^;::Send, !^+{F7}
#IfWinActive

#IfWinNotActive, ahk_exe WindowsTerminal.exe
  !BS::Send ^{BS}
#IfWinNotActive

#IfWinActive, ahk_exe WindowsTerminal.exe
  !,::Send, ^+{Tab}
  !.::Send, ^{Tab}
#IfWinActive

; CapsLock & Space::^!+1 ; launch switcheroo
#IfWinNotActive, ahk_exe keypirinha-x64.exe
  CapsLock & Space::
    Send, !{Space}
    sleep 30
    Send, ..
    Send, {tab}
  return
#IfWinNotActive

#IfWinActive ahk_class AutoHotkeyGUI
  ^BS:: Send ^+{left}{del}
  ^u:: Send +{home}{del}
#IfWinActive

#IfWinActive ahk_class SUMATRA_PDF_FRAME
  j:: Send {WheelDown}
  k:: Send {WheelUp}
  !WheelDown:: Send, !{WheelDown}
  !WheelUp:: Send, !{WheelUp}
#IfWinActive
