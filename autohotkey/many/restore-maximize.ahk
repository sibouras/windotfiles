; -------------------------------------
; Restore/Maximize with hotkey
; -------------------------------------
#m::																									; Maximize/Restore active window with Super+M.
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