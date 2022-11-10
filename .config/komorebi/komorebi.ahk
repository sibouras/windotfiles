#SingleInstance Force
#WinActivateForce

; You can generate a fresh version of this file with "komorebic ahk-library"
#Include %A_ScriptDir%\komorebic.lib.ahk
; https://github.com/LGUG2Z/komorebi/#generating-common-application-specific-configurations
#Include %A_ScriptDir%\komorebi.generated.ahk

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Ensure there is 1 workspace created on monitor 0
EnsureWorkspaces(0, 1)

; Configure the invisible border dimensions
; InvisibleBorders(7, 0, 14, 7)

; Configure the 1st workspace
WorkspaceName(0, 0, "I")

; Uncomment the next two lines if you want a visual border drawn around the focused window
ActiveWindowBorderColour(66, 165, 245, "single") ; this is a nice blue colour
ActiveWindowBorder("enable")

; Allow komorebi to start managing windows
CompleteConfiguration()

MouseFollowsFocus("disable")

!o::ToggleMouseFollowsFocus()

; Change the focused window
!h::Focus("left")
!j::Focus("down")
!k::Focus("up")
!l::Focus("right")

; Move the focused window in a given direction
!^h::Move("left")
!^j::Move("down")
!^k::Move("up")
!^l::Move("right")

; Move the focused window in a given direction
!+h::ResizeAxis("horizontal", "decrease")
!+l::ResizeAxis("horizontal", "increase")
!+j::ResizeAxis("vertical", "increase")
!+k::ResizeAxis("vertical", "decrease")

; Stack the focused window in a given direction
^!+h::Stack("left")
^!+l::Stack("right")
^!+k::Stack("up")
^!+j::Stack("down")

; Cycle stack
!]::CycleStack("next")
![::CycleStack("previous")

; Unstack the focused window
!+d::Unstack()

; Promote the focused window to the top of the tree
!+Enter::Promote()

; bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack
!+c::WorkspaceLayout(0, 0, "columns")
!+b::WorkspaceLayout(0, 0, "bsp")

!+t::ToggleTiling()

; Toggle the Monocle layout for the focused window
^!+f::ToggleMonocle()

; Toggle native maximize for the focused window
!+=::ToggleMaximize()

; Flip horizontally
; !x::FlipLayout("horizontal")

; Flip vertically
; !y::FlipLayout("vertical")

; Force a retile if things get janky
^!r::Retile()

; Float the focused window
!t::ToggleFloat()

; Pause responding to any window events or komorebic commands
^!p::TogglePause()

; Switch to workspace
!1::FocusWorkspace(0)
!2::FocusWorkspace(1)
!3::FocusWorkspace(2)
!4::FocusWorkspace(3)

; Move window to workspace
!+1::MoveToWorkspace(0)
!+2::MoveToWorkspace(1)
!+3::MoveToWorkspace(2)
!+4::MoveToWorkspace(3)

!+i::
Run, komorebic.exe save ~/.config/komorebi/layouts/primary.json
return

!+m::
Run, komorebic.exe load ~/.config/komorebi/layouts/primary.json
return

#+o::ReloadConfiguration()

#+k::Reload

^#+k::
Stop()
exitapp
