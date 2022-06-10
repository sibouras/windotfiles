RAlt & v::ToggleWindowVisibility("ahk_exe nvy.exe")
RAlt & e::ToggleWindowVisibility("ahk_class CabinetWClass")
; RAlt & e::ToggleWindowVisibility("ahk_exe fman.exe")
RAlt & f::ToggleWindowVisibility("ahk_exe mpv.exe")
RAlt & d::ToggleWindowVisibility("ahk_exe code.exe")
RAlt & r::ToggleWindowVisibility("Alacritty")
RAlt & w::ToggleWindowVisibility("ahk_exe WindowsTerminal.exe")
; RAlt & x::ToggleWindowVisibility("ahk_exe joplin.exe")

ToggleWindowVisibility(windowClass) {
  IfWinExist, %windowClass%
  {
    IfWinActive, %windowClass%
      WinMinimize, %windowClass%
    else
      WinActivate, %windowClass%
  }
  ; else {
  ;   word_array := StrSplit(windowClass, A_Space, "") ; Omits periods.
  ;   MsgBox % word_array[2] " is not open!"
  ; }
}

RAlt & s::
  brave = ahk_exe brave.exe
  edge = ahk_exe msedge.exe
  if WinExist(brave) {
    IfWinActive, %brave%
      WinMinimize, %brave%
    else
      WinActivate, %brave%
  }
  else if WinExist(edge) {
    IfWinActive, %edge%
      WinMinimize, %edge%
    else
      WinActivate, %edge%
  }
return

RAlt & b::
  nvy = ahk_exe nvy.exe
  Loop {
    WinWait, %nvy%
    WinMove, %nvy%,, 188, 33, 1600, 1000
    WinSet, Style, -0xC00000, A ; toggle titlebar
    WinWaitClose
  }
return

; minimize active window and restore it
RAlt & c::
  IfWinExist, ahk_id %lastWindow%
  {
    WinGet, WinState, MinMax, ahk_id %lastWindow%
    If WinState = -1
      WinActivate
    else
      WinMinimize
    lastWindow:= ; remove this line if you want minimize/toggle only one window
  }
  else
  {
    lastWindow:= WinExist("A")
    WinMinimize, ahk_id %lastWindow%
  }
return

!i::Send, ^!{Tab}
#IfWinActive, ahk_class MultitaskingViewFrame
  h::Left
  j::Down
  k::Up
  l::Right
  q::Delete
#IfWinActive

; switch to previous window
!j::
  winNumber = 0
  WinGet, win, List
  Loop, %win% {
    WinGetTitle, ttitle, % winTitle := "ahk_id " win%A_Index% ; Window title
    WinGet, proc, ProcessName, %winTitle% ; Window process
    WinGetClass, class, %winTitle% ; Window class
    winNumber += !(class ~= "i)Toolbar|#32770") && ttitle > ""
    && (ttitle != "Program Manager" || proc != "Explorer.exe")
  } Until (winNumber = 2)
  WinActivate, %winTitle%
Return

; switch between all windows of the current window class
listIndex = 1
#WinActivateForce
!k::
Beginning:
  WinGetClass, activeWindowClass, A
  WinGet, activeWindowID, ID, A
  ; get window list
  WinGet, List, List, ahk_class %activeWindowClass%,, Program Manager
  listIndex++
  if (listIndex > List)
    listIndex = %List%

  Id := List%listIndex%
  if (activeWindowID != Id) {
    WinGetTitle, title, ahk_id %Id%
    if (title) {
      ; exclude windows without a size
      WinGetPos,,,W,H,ahk_id %Id%
      if (W AND H) {
        WinActivate, ahk_id %Id%
        return
      }
    }
    WinActivate, ahk_id %Id%
    Goto, Beginning
  }
return

; Alt+Tab with mouse wheel
XButton2 & WheelDown::AltTab
XButton2 & WheelUp::ShiftAltTab
; Alt+Tab menu
XButton2 & LButton::Send, ^!{Tab}
XButton2 & RButton::Send, #{Tab}
XButton2 UP::return
#IfWinActive ahk_exe mpv.exe
  XButton2 UP::Send, {XButton2}
#IfWinActive
