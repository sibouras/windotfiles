#SingleInstance, force
; SetTitleMatchMode, 2
#WinActivateForce ; this may prevent task bar buttons from flashing when different windows are activated quickly one after the other

RAlt & z::
  devtools = DevTools
  if WinExist(devtools)
    WinActivate, %devtools%
return

RAlt & c::
  nvim = ahk_exe alacritty.exe
  edge = ahk_exe msedge.exe
  devtools = DevTools
  ; WinGetTitle, OutputVar, %devtools%
  if WinExist(devtools) {
    WinActivate, %devtools%
  }
  else
    WinActivate, %edge%
  WinActivate, %nvim%
return
