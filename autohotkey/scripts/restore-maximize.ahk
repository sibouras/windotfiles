#NoEnv
#SingleInstance force

WinLastPosList := {}

; center active window
!^o::
  SysGet Mon,MonitorWorkArea  ; This grabs the actual work space of the desktop (i.e. minus the taskbar)
  WinGetPos , posX, posY, windowWidth, windowHeight, A
  WinExist("A")
	WinGet, activeID, ID, A
  WinLastPosList[activeID] := [posX, posY]
  WinMove A,,(MonRight-windowWidth)/2,(MonBottom-windowHeight)/2
Return

; restore to last known pos
!^+o::
  WinExist("A")
	WinGet, activeID, ID, A
  lastPos := WinLastPosList[activeID]
  WinMove, lastPos.1, lastPos.2
Return

; Maximize/Restore active window
!m::
  WinGet, active_id, ID, A
  WinGet, checkmax, MinMax, A
  If(checkmax == 1) {
    WinGet, active_id, ID, A
    WinRestore, ahk_id %active_id%
  } else {
    WinGetClass, class, ahk_id %active_id%
    If class not in ahk_class WorkerW,Shell_TrayWnd, Button, SysListView32,Progman,#32768
      WinMaximize, ahk_id %active_id%
  }
return
