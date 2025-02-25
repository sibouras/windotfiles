; https://overflow.projectsegfau.lt/questions/76487153/how-to-globally-hide-show-the-mouse-cursor-in-windows-programmatically#78443758
#Requires AutoHotkey v2.0

CoordMode("mouse", "screen") ; Place at top of code

OnExit (*) => SystemCursor("Show")  ; Ensure the cursor is made visible when the script exits.

; global variables
count := 0
mX0 := 0
mY0 := 0

CheckIdle() {
  global mX0, mY0
  ; global count
  ; ToolTip ++count " " mX0 " " mY0
  MouseGetPos(&mX, &mY)
  if (mX0 != mX && mY0 != mY)
  {
    SystemCursor("Show")
    mX0 := mX, mY0 := mY
    SetTimer(CheckIdle, 0)
  }
}

; windows terminal hides the mouse while typing and unhides it upon LoseFocus
; which causes it to show even when hidden on a video
; https://github.com/microsoft/terminal/pull/8629
; #HotIf WinActive("ahk_exe windowsterminal.exe")
~Alt Up::
{
  ; Get the current mouse position, and store its coordinates
  global mX0, mY0
  MouseGetPos(&mX0, &mY0)

  SystemCursor("Hide")
  ; Set a timer to check if the mouse is still idle after 50ms
  SetTimer(CheckIdle, 100)
}


MouseIsOver(WinTitle) {
  MouseGetPos , , &Win
  return WinExist(WinTitle " ahk_id " Win)
}

; #c:: SystemCursor("Toggle")  ; Win+C hotkey to toggle the cursor on and off.

; https://www.autohotkey.com/docs/v2/lib/DllCall.htm#ExHideCursor
SystemCursor(cmd)  ; cmd = "Show|Hide|Toggle|Reload"
{
  static visible := true, c := Map()
  static sys_cursors := [32512, 32513, 32514, 32515, 32516, 32642
    , 32643, 32644, 32645, 32646, 32648, 32649, 32650]
  if (cmd = "Reload" or !c.Count)  ; Reload when requested or at first call.
  {
    for i, id in sys_cursors
    {
      h_cursor := DllCall("LoadCursor", "Ptr", 0, "Ptr", id)
      h_default := DllCall("CopyImage", "Ptr", h_cursor, "UInt", 2
        , "Int", 0, "Int", 0, "UInt", 0)
      h_blank := DllCall("CreateCursor", "Ptr", 0, "Int", 0, "Int", 0
        , "Int", 32, "Int", 32
        , "Ptr", Buffer(32 * 4, 0xFF)
        , "Ptr", Buffer(32 * 4, 0))
      c[id] := { default: h_default, blank: h_blank }
    }
  }
  switch cmd
  {
    case "Show": visible := true
    case "Hide": visible := false
    case "Toggle": visible := !visible
    default: return
  }
  for id, handles in c
  {
    h_cursor := DllCall("CopyImage"
      , "Ptr", visible ? handles.default : handles.blank
      , "UInt", 2, "Int", 0, "Int", 0, "UInt", 0)
    DllCall("SetSystemCursor", "Ptr", h_cursor, "UInt", id)
  }
}
