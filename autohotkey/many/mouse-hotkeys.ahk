; Keep RButton working (mostly) normally.
RButton::RButton
RButton & WheelUp::Volume_Up
RButton & WheelDown::Volume_Down
RButton & MButton::Volume_Mute
RButton & LButton::MButton

#MaxHotkeysPerInterval 500
#If MouseIsOver("ahk_class Shell_TrayWnd")
{
  WheelUp::Volume_Up
  WheelDown::Volume_Down
  RButton & LButton::Media_Play_Pause
  XButton2::Media_Next
  XButton1::Media_Prev
}

MouseIsOver(WinTitle) {
  MouseGetPos,,, Win
return WinExist(WinTitle . " ahk_id " . Win)
}
#If

XButton1::XButton1
XButton1 & WheelUp::^PgUp
XButton1 & WheelDown::^PgDn
; Alt+Tab with mouse wheel
XButton2::XButton2
XButton2 & WheelUp::ShiftAltTab
XButton2 & WheelDown::AltTab
; Alt+Tab menu
XButton2 & LButton::Send, ^!{Tab}
XButton2 & RButton::Send, #{Tab}

#IfWinActive, ahk_class XamlExplorerHostIslandWindow
  RButton::Send, {Enter}
  XButton2::Send, {Home}{Enter}
#IfWinActive
