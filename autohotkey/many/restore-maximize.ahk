CenterRestore(operation) {
  static WinLastPosList := {}
  WinExist("A")
  WinGet, activeID, ID, A
  if (operation == "center") {
    SysGet Mon,MonitorWorkArea  ; This grabs the actual work space of the desktop (i.e. minus the taskbar)
    WinGetPos , posX, posY, windowWidth, windowHeight, A
    WinLastPosList[activeID] := [posX, posY]
    WinMove A,,(MonRight-windowWidth)/2,(MonBottom-windowHeight)/2
  } else if (operation == "restore") {
    lastPos := WinLastPosList[activeID]
    WinMove, lastPos.1, lastPos.2
  }
}

; center active window
!^o::CenterRestore("center")
; restore to last known pos
!^+o::CenterRestore("restore")

; Maximize/Restore active window
$!m::
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
