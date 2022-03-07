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

  ; No single alt
  Alt::KeyWait Alt
}
#IfWinActive

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
  !w::Send, ^{Tab}
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
