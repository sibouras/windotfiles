RButton::
  ;Keep AppsKey working (mostly) normally.
  Send {RButton}
Return

RButton & WheelUp:: Send {Volume_Up}
RButton & WheelDown:: Send {Volume_Down}
RButton & MButton:: Send {Volume_Mute}
RButton & LButton:: MButton

#MaxHotkeysPerInterval 500
#If MouseIsOver("ahk_class Shell_TrayWnd")
  WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}
MButton::Send {Media_Play_Pause}
XButton2::Send {Media_Next}
XButton1::Send {Media_Prev}

MouseIsOver(WinTitle) {
  MouseGetPos,,, Win
return WinExist(WinTitle . " ahk_id " . Win)
}
#If

!q::Send !{f4}

#a:: suspend
