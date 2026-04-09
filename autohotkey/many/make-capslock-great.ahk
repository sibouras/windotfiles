SetCapsLockState, AlwaysOff

CapsLock & `;::Capslock

q:: Esc
^q:: Send, ^q
^!q:: Send, ^!q
$!q:: WinClose, A
CapsLock & q:: q
9:: Send, {BS}
CapsLock & 9:: ^BS
CapsLock & 0:: 9

CapsLock & k:: Up
CapsLock & j:: Down
CapsLock & h:: Left
CapsLock & l:: Right
CapsLock & i:: Home
CapsLock & o:: End
CapsLock & ':: Del
CapsLock & u:: PgUp
CapsLock & p:: PgDn
CapsLock & a:: Lwin
CapsLock & s:: Alt
CapsLock & d:: Shift
CapsLock & f:: Ctrl
CapsLock & g:: AppsKey
CapsLock & y:: ^y
CapsLock & c:: MButton
CapsLock & v:: LButton
CapsLock & [:: ^[
CapsLock & ]:: ^]
CapsLock & \:: Insert
CapsLock & t:: ^t
CapsLock & w:: ^w
CapsLock & .:: ^PgDn
CapsLock & ,:: ^PgUp

; CapsLock & c:: Run nircmd.exe mutesysvolume 0 microphone ; unmute
; CapsLock & x:: Run nircmd.exe mutesysvolume 1 microphone ; Mute
; CapsLock & z:: Run nircmd.exe mutesysvolume 2 microphone ; Toggle

; firefox and wt need y to be longer than the titlebar
; CapsLock & 9:: ControlClick, x500 y200, A,, WheelDown,, NA
; CapsLock & 0:: ControlClick, x500 y200, A,, WheelUp,, NA
wheel(direction){
  WinGetPos,,, Width, Height, A
  CenterX := Width / 2
  CenterY := Height / 2
  ControlClick, x%CenterX% y%Centery%, A,, %direction%,, NA
}
CapsLock & e:: wheel("WheelDown")
CapsLock & r:: wheel("WheelUp")

F2:: Volume_Down
F3:: Volume_Up
F4:: Volume_Mute

CapsLock & 1:: F1
CapsLock & 2:: F2
CapsLock & 3:: F3
CapsLock & 4:: F4

CapsLock & F5:: Media_Play_Pause
CapsLock & F6:: Media_Stop
CapsLock & F7:: Media_Prev
CapsLock & F8:: Media_Next


CapsLock & m::
  Input Key, L1 M
  If Key = f
  {
    if getKeyState("alt") = 0 {
      EnvGet, vUserProfile, USERPROFILE
      ; Run, %vUserProfile%\scoop\apps\mpv\current\mpv.exe --no-terminal --no-border --config-dir=%A_AppData%\mpv
      Run, mpv.exe
    }
    else {
      ; opts := "keep_session-auto_save=no,keep_session-auto_load=no"
      ; Run, mpv.exe --script-opts=%opts% %clipboard%
      Run, mpv.exe %clipboard%
    }
  }
  else if Key = s
    Run helium.exe
  else if Key = a
    Run firefox.exe
  else if Key = d
    Run code.exe
  else if Key = t
  {
    Run nvy.exe
    WinWait, Nvy,, 1
    if ErrorLevel {
      MsgBox, WinWait timed out.
      return
    }
    else {
      WinActivate, Nvy
      ; sleep 400
      ; WinMove, Nvy,, 260, 47, 1400, 985
    }
  }
  else if Key = v
  {
    Run neovide.exe --frame none
  }
  else if Key = w
  {
    Run wt.exe,,, NewPID
    ; WinWaitActive, ahk_pid %NewPID% ; doesn't work
    ; sleep 400
    ; Send, !+{l}
  }
  else if Key = e
    Run explorer.exe
  else if Key = x
    Run %A_AppData%\Spotify\spotify.exe
  else if Key = r
  {
    ; EnvGet, vUserProfile, USERPROFILE
    ; RunWait, alacritty.exe --working-directory "%vUserProfile%", , Min
    ; Run %vUserProfile%\scoop\apps\alacritty\current\alacritty.exe --working-directory %vUserProfile%,,, NewPID
    Run alacritty.exe,,, NewPID
    ; WinWaitActive, ahk_pid %NewPID%
    ; Send, !+{l}
  }
  else if Key = g
  {
    ; place glasswire icon next to `#b` menu in taskbar
    if not WinExist("ahk_exe glasswire.exe") {
      Send, #b{right}{space}
      WinWaitActive, ahk_exe glasswire.exe
      ; Send, !{Esc}+!{Esc}
      MsgBox,,,,0.001 ; open msgbox for 1ms
    }

    ; opening an app from taskbar then closing it focuses the taskbar

    ; if not WinExist("ahk_exe glasswire.exe") {
    ;   WinHide, ahk_class Shell_TrayWnd
    ;   WinHide, ahk_class Shell_SecondaryTrayWnd
    ;   Send, #b{right}{space}
    ;   sleep 100
    ;   WinActivate, ahk_exe glasswire.exe
    ;   WinWaitNotActive, ahk_exe glasswire.exe
    ;   sleep 100
    ;   WinShow, ahk_class Shell_TrayWnd
    ;   WinShow, ahk_class Shell_SecondaryTrayWnd
    ; }
  }
return
