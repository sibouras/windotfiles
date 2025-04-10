#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; https://overflow.projectsegfau.lt/questions/76487153/how-to-globally-hide-show-the-mouse-cursor-in-windows-programmatically#78443758
; https://www.reddit.com/r/AutoHotkey/comments/gss23p/mouse_move_trigger

CoordMode, Mouse, Screen ; Place at top of code

OnExit, ShowCursor  ; Ensure the cursor is made visible when the script exits.
return

ShowCursor:
SystemCursor("On")
ExitApp

; Checks if the mouse has moved, and if so, shows it and records the new position
count := 0

CheckIdle:
  MouseGetPos mX, mY
  ; count++
  ; ToolTip % count
  if (mX0 != mX && mY0 != mY)
  {
    SystemCursor("On")
    mX0 := mX, mY0 := mY
    SetTimer, CheckIdle, Off
  }
return

~Alt Up::
  ; Get the current mouse position, and store its coordinates
  MouseGetPos mX0, mY0

  SystemCursor("Off")
  ; Set a timer to check if the mouse is still idle after 50ms
  SetTimer, CheckIdle, 100
return

; https://www.autohotkey.com/docs/v1/lib/DllCall.htm#HideCursor
SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
  static AndMask, XorMask, $, h_cursor
      ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
      , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors
      , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors
  if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call
  {
    $ := "h"                                       ; active default cursors
    VarSetCapacity( h_cursor,4444, 1 )
    VarSetCapacity( AndMask, 32*4, 0xFF )
    VarSetCapacity( XorMask, 32*4, 0 )
    system_cursors := "32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650"
    StringSplit c, system_cursors, `,
    Loop %c0%
    {
      h_cursor   := DllCall( "LoadCursor", "Ptr",0, "Ptr",c%A_Index% )
      h%A_Index% := DllCall( "CopyImage", "Ptr",h_cursor, "UInt",2, "Int",0, "Int",0, "UInt",0 )
      b%A_Index% := DllCall( "CreateCursor", "Ptr",0, "Int",0, "Int",0
        , "Int",32, "Int",32, "Ptr",&AndMask, "Ptr",&XorMask )
    }
  }
  if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
    $ := "b"  ; use blank cursors
  else
    $ := "h"  ; use the saved cursors

  Loop %c0%
  {
    h_cursor := DllCall( "CopyImage", "Ptr",%$%%A_Index%, "UInt",2, "Int",0, "Int",0, "UInt",0 )
    DllCall( "SetSystemCursor", "Ptr",h_cursor, "UInt",c%A_Index% )
  }
}
