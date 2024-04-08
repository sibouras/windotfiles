#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#singleInstance, force

; code explanation: https://www.reddit.com/r/AutoHotkey/comments/ac1epn/groggy_guide_admin_rights_privilege_level/
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")) {
  try {
    if A_IsCompiled
      Run *RunAs "%A_ScriptFullPath%" /restart
    else
      Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
  }
  ExitApp
}

!F1::Run, cmd.exe /c altsnap -l1,, hide
!F2::Run, cmd.exe /c altsnap -l2,, hide
!F3::Run, cmd.exe /c altsnap -l3,, hide
