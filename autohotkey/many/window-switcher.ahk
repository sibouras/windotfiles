RAlt & e::ToggleWindowVisibility("ahk_class CabinetWClass")
RAlt & d::ToggleWindowVisibility("ahk_exe code.exe")
RAlt & r::ToggleWindowVisibility("Alacritty")
RAlt & w::ToggleWindowVisibility("ahk_exe WindowsTerminal.exe")
RAlt & g::ToggleWindowVisibility("ahk_exe Glasswire.exe")
RAlt & x::ToggleWindowVisibility("ahk_exe Spotify.exe")

ToggleWindowVisibility(windowClass) {
  if WinExist(windowClass) {
    if WinActive(windowClass)
      WinMinimize, %windowClass%
    else
      WinActivate, %windowClass%
  }
  ; else {
  ;   word_array := StrSplit(windowClass, A_Space, "") ; Omits periods.
  ;   MsgBox % word_array[2] " is not open!"
  ; }
}

RAlt & f::
  mpv = ahk_exe mpv.exe
  if WinExist(mpv) {
    if WinActive(mpv) {
      WinMinimize, %mpv%
    } else {
      WinGet, active_id, ID, A
      WinGet, proc, ProcessName, ahk_id %active_id%
      ; when the focus is on brave window, minimizing then activating mpv
      ; causes keys to behave strangely.
      if (proc == "brave.exe") {
        WinRestore, ahk_exe %mpv%
      }
      WinActivate, %mpv%
    }
  }
return

RAlt & b::
  SetTitleMatchMode, 2
  brave = ahk_exe brave.exe
  GroupAdd, braveGroup, - Brave
  GroupAdd, braveGroup, DevTools
  If WinActive(brave)
    GroupActivate, braveGroup, r
  else
    WinActivate %brave%
return

RAlt & a::
  SetTitleMatchMode, 2
  edge = ahk_exe msedge.exe
  GroupAdd, edgeGroup, Edge
  GroupAdd, edgeGroup, DevTools
  If WinActive(edge)
    GroupActivate, edgeGroup, r
  else
    WinActivate %edge%
return

RAlt & s::
  firefoxClass = ahk_class MozillaWindowClass
  GroupAdd, firefoxGroup, %firefoxClass%
  If WinActive(firefoxClass)
    GroupActivate, firefoxGroup, r
  else
    WinActivate %firefoxClass%
return

RAlt & t::
  nvyClass = ahk_class Nvy_Class
  GroupAdd, nvyGroup, %nvyClass%
  WinGet, nvyList, List, %nvyClass%
  If WinActive(nvyClass)
    If nvyList = 1
      WinMinimize, %nvyClass%
    else
      GroupActivate, nvyGroup, r
  else
    WinActivate %nvyClass%
return

RAlt & v::
  neovide = ahk_exe neovide.exe
  IfWinExist, %neovide%
    WinActivate, %neovide%
return

; minimize active window and restore it
; RAlt & c::
;   IfWinExist, ahk_id %lastWindow%
;   {
;     WinGet, WinState, MinMax, ahk_id %lastWindow%
;     If WinState = -1
;       WinActivate
;     else
;       WinMinimize
;     lastWindow:= ; remove this line if you want minimize/toggle only one window
;   }
;   else
;   {
;     lastWindow:= WinExist("A")
;     WinMinimize, ahk_id %lastWindow%
;   }
; return

!i::Send, ^!{Tab}
; #IfWinActive, ahk_class MultitaskingViewFrame ; doesn't work in windows 11
#IfWinActive, ahk_class XamlExplorerHostIslandWindow
  h::Left
  j::Down
  k::Up
  l::Right
  d::Delete
  i::Enter
  q::Esc
#IfWinActive

; focus previous window
; from: https://www.autohotkey.com/boards/viewtopic.php?t=97358
!o::focus(2)
!p::focus(3)
!u::focus(4)

focus(nInStack) {
 winNumber := 0
 WinGet win, List
 Loop % win {
  this_id := win%A_Index%
  id := % "ahk_id " this_id
  WinGet, ExStyle, ExStyle, %id%
  WinGetTitle ttitle, % winTitle := "ahk_id " win%A_Index% ; Window title
  WinGet proc, ProcessName, %winTitle%                     ; Window process
  WinGetClass class, %winTitle%                            ; Window class
  ; https://www.autohotkey.com/docs/commands/WinGet.htm#ExStyle
  ; 0x8 is WS_EX_TOPMOST(always-on-top)
  winNumber += !(class ~= "i)Toolbar|#32770") && ttitle > "" && !(ExStyle & 0x8)
               && (ttitle != "Program Manager" || proc != "Explorer.exe")
 } Until Min(nInStack, win) = winNumber
 WinActivate % winTitle
}

; switch between all windows of the current window class
listIndex = 1
#WinActivateForce
!+o::
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

; RAlt & b::
;   nvy = ahk_exe nvy.exe
;   Loop {
;     WinWait, %nvy%
;     WinMove, %nvy%,, 188, 33, 1600, 1000
;     WinSet, Style, -0xC00000, A ; toggle titlebar
;     WinWaitClose
;   }
; return

; RAlt & s::
;   WinGet, firefoxList, List, ahk_class MozillaWindowClass
;   WinGet, activeWindowID, ID, A
;   firefoxClass = ahk_class MozillaWindowClass
;   IfWinActive, %firefoxClass%
;   {
;     If activeWindowID = %firefoxList1%
;       WinActivate, ahk_id %firefoxList2%
;     else If activeWindowID = %firefoxList2%
;       WinActivate, ahk_id %firefoxList1%
;   }
;   else
;     WinActivate, %firefoxClass%
; return

; f2::
;   DetectHiddenWindows, On
;   window = ahk_exe notepad.exe
;   IfWinExist, %window%
;   {
;     IfWinActive, %window%
;     {
;       WinHide, %window%
;       Send, !{Esc}
;     }
;     else
;     {
;       WinShow, %window%
;       WinActivate, %window%
;     }
;   }
; return
