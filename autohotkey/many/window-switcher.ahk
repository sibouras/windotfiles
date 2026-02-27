RAlt & e::ToggleWindowVisibility("ahk_class CabinetWClass")
RAlt & d::ToggleWindowVisibility("ahk_exe code.exe")
RAlt & r::ToggleWindowVisibility("Alacritty")
RAlt & w::ToggleWindowVisibility("ahk_exe WindowsTerminal.exe")
RAlt & x::ToggleWindowVisibility("ahk_exe Spotify.exe")

ToggleWindowVisibility(windowClass) {
  if WinExist(windowClass) {
    if WinActive(windowClass)
      WinMinimize, %windowClass%
    else {
      ; fix alt key getting stuck in mpv when holding RAtl then focusing wt -> firefox -> mpv
      if WinActive("ahk_exe mpv.exe") {
        Send, {Ralt up}
      }
      ; Send, {RAlt up}
      WinActivate, %windowClass%
    }
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

RAlt & g::
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
  SetTitleMatchMode, 2
  helium = ahk_exe chrome.exe
  GroupAdd, heliumGroup, - Helium
  GroupAdd, heliumGroup, DevTools
  If WinActive(helium)
    GroupActivate, heliumGroup, r
  else
    WinActivate %helium%
return

RAlt & a::
  firefoxClass = ahk_class MozillaWindowClass
  GroupAdd, firefoxGroup, %firefoxClass%
  If WinActive(firefoxClass)
    GroupActivate, firefoxGroup, r
  else {
    ; fix alt key getting stuck in mpv when holding RAtl then focusing firefox -> mpv
    if WinActive("ahk_exe mpv.exe") {
      Send, {Ralt up}
    }
    WinActivate %firefoxClass%
  }
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
  q::Send, !{Esc Down} ; `Down` to not escape from fullscreen video in a browser
  Capslock::Send, !{Esc Down}
#IfWinActive

; focus previous window
; from: https://www.autohotkey.com/boards/viewtopic.php?t=97358
$!o::
$!`::
  focus(2)
return
$!\::focus(3)

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
  ; fix alt key getting stuck when switching away from mpv
  ; if WinActive("ahk_exe mpv.exe") {
    ; Send, {LAlt up}{RAlt up} ; send both {LAlt up} and {RAlt up} instead of {Alt up} to make it work when when holding Ralt+o
  ; }
  ; some programs like explorer, msedge, brave.. focus the menu when pressing !o fast
  ; NOTE: this also fixes the mpv issue above
  ; Send, {o up}
  ; NOTE: this is also fixed by using $ https://www.autohotkey.com/docs/v1/Hotkeys.htm#Symbols
  WinActivate % winTitle
}

; switch between all windows of the current window class
; https://superuser.com/a/1783158
!+o::
  WinGetClass, win_class, A
  WinGet, win_id, ID, A
  WinGet, active_process_name, ProcessName, A

  ; We have to be extra careful about explorer.exe since that process is responsible for more than file explorer
  if (active_process_name = "explorer.exe") {
    WinGet, win_list, List, ahk_exe %active_process_name% ahk_class %win_class%
  } else {
    ; WinGet, win_list, List, ahk_exe %active_process_name% ; alacritty spawns 2 windows
    WinGet, win_list, List, ahk_exe %active_process_name% ahk_class %win_class%
  }

  ; Calculate index of next window. Since activating a window puts it at the top of the list, we have to take from the bottom.
  next_window_i := win_list
  next_window_id := win_list%next_window_i%

  ; Activate the next window and send it to the top.
  WinActivate, ahk_id %next_window_id%
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
