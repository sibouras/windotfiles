#SingleInstance Force

Run, komorebic.exe start
sleep, 2000

; Enable hot reloading of changes to this file
Run, komorebic.exe watch-configuration enable, , Hide

; Configure the invisible border dimensions
; Run, komorebic.exe invisible-borders 18 10 37 27, , Hide
Run, komorebic.exe invisible-borders 18 16 37 33, , Hide

; Enable focus follows mouse
; Run, komorebic.exe focus-follows-mouse enable, , Hide

; Disable mouse follows focus
Run, komorebic.exe mouse-follows-focus disable, , Hide

; Ensure there are 3 workspaces created on monitor 0
Run, komorebic.exe ensure-workspaces 0 5, , Hide

; Give the workspaces some optional names
Run, komorebic.exe workspace-name 0 0 bsp, , Hide
Run, komorebic.exe workspace-name 0 1 columns, , Hide
Run, komorebic.exe workspace-name 0 2 thicc, , Hide
Run, komorebic.exe workspace-name 0 3 matrix, , Hide
Run, komorebic.exe workspace-name 0 4 floaty, , Hide

; Set the padding of the different workspaces
Run, komorebic.exe workspace-padding 0 0 0, , Hide
Run, komorebic.exe workspace-padding 0 1 0, , Hide
Run, komorebic.exe workspace-padding 0 2 0, , Hide
Run, komorebic.exe workspace-padding 0 3 0, , Hide
Run, komorebic.exe workspace-padding 0 4 0, , Hide

; Set the layouts of different workspaces
; Run, komorebic.exe workspace-layout 0 1 columns, , Hide

; Set the floaty layout to not tile any windows
Run, komorebic.exe workspace-tiling 0 4 disable, , Hide

; Always show chat apps on the second workspace
; Run, komorebic.exe workspace-rule exe slack.exe 0 1, , Hide
; Run, komorebic.exe workspace-rule exe Discord.exe 0 1, , Hide

; Always float IntelliJ popups, matching on class
Run, komorebic.exe float-rule class SunAwtDialog, , Hide
; Always float Control Panel, matching on title
Run, komorebic.exe float-rule title "Control Panel", , Hide
; Always float Task Manager, matching on class
Run, komorebic.exe float-rule class TaskManagerWindow, , Hide
Run, komorebic.exe float-rule class Qt5QWindowIcon, ,Hide   ; glasswire
Run, komorebic.exe float-rule class Qt5QWindow, ,Hide   ; fman popup
Run, komorebic.exe float-rule class ApplicationFrameWindow, ,Hide   ; Alarms&clock

; Always float Wally, matching on executable name
Run, komorebic.exe float-rule exe Wally.exe, , Hide
Run, komorebic.exe float-rule exe wincompose.exe, , Hide
Run, komorebic.exe float-rule exe mpv.exe, , Hide   ; mpv
Run, komorebic.exe float-rule exe PowerToys.ColorPickerUI.exe, , Hide   ; powertoys color picker
Run, komorebic.exe float-rule exe "xampp-control.exe", , Hide
Run, komorebic.exe float-rule exe FancyZonesEditor.exe, , Hide  ; powertoys fancyzones editor
Run, komorebic.exe float-rule exe SnapTimer.exe, , Hide  ; powertoys fancyzones editor


; Always float Calculator app, matching on window title
Run, komorebic.exe float-rule title Calculator, , Hide

; Always manage forcibly these applications that don't automatically get picked up by komorebi
Run, komorebic.exe manage-rule exe TIM.exe, , Hide

; Identify applications that close to the tray
Run, komorebic.exe identify-tray-application exe Discord.exe, , Hide
Run, komorebic.exe identify-tray-application exe ShareX.exe, , Hide

; Identify applications that have overflowing borders
Run, komorebic.exe identify-border-overflow exe Discord.exe, , Hide

; Change the focused window, Alt + Vim direction keys
!h::
Run, komorebic.exe focus left, , Hide
return

!j::
Run, komorebic.exe focus down, , Hide
return

!k::
Run, komorebic.exe focus up, , Hide
return

!l::
Run, komorebic.exe focus right, , Hide
return

; Move the focused window in a given direction, Alt + Shift + Vim direction keys
!^h::
Run, komorebic.exe move left, , Hide
return

!^j::
Run, komorebic.exe move down, , Hide
return

!^k::
Run, komorebic.exe move up, , Hide
return

!^l::
Run, komorebic.exe move right, , Hide
return

; Move the focused window in a given direction, Alt + Shift + Vim direction keys
!+h::
Run, komorebic.exe resize-axis horizontal decrease, , Hide
return

!+l::
Run, komorebic.exe resize-axis horizontal increase, , Hide
return

!+j::
Run, komorebic.exe resize-axis vertical increase, , Hide
return

!+k::
Run, komorebic.exe resize-axis vertical decrease, , Hide
return

; Stack the focused window in a given direction, Alt + Shift + direction keys
!+Left::
Run, komorebic.exe stack left, , Hide
return

!+Down::
Run, komorebic.exe stack down, , Hide
return

!+Up::
Run, komorebic.exe stack up, , Hide
return

!+Right::
Run, komorebic.exe stack right, , Hide
return

!]::
Run, komorebic.exe cycle-stack next, , Hide
return

![::
Run, komorebic.exe cycle-stack previous, , Hide
return

; Unstack the focused window, Alt + Shift + D
!+d::
Run, komorebic.exe unstack, , Hide
return

; Promote the focused window to the top of the tree, Alt + Shift + Enter
!+Enter::
Run, komorebic.exe promote, , Hide
return

; Switch to an equal-width, max-height column layout on the main workspace, Alt + Shift + C
!+c::
Run, komorebic.exe workspace-layout 0 0 columns, , Hide
return

; Switch to the default bsp tiling layout on the main workspace, Alt + Shift + T
!+t::
Run, komorebic.exe workspace-layout 0 0 bsp, , Hide
return

; Toggle the Monocle layout for the focused window, Alt + Ctrl + Shift + F
^!+f::
Run, komorebic.exe toggle-monocle, , Hide
return

; Toggle native maximize for the focused window, Alt + Shift + =
!+=::
Run, komorebic.exe toggle-maximize, , Hide
return

; Flip horizontally, Alt + X
; !x::
; Run, komorebic.exe flip-layout horizontal, , Hide
; return

; Flip vertically, Alt + Y
; !y::
; Run, komorebic.exe flip-layout vertical, , Hide
; return

; Force a retile if things get janky, Alt + Shift + R
^!r::
Run, komorebic.exe retile, , Hide
return

; Float the focused window, Alt + T
!t::
Run, komorebic.exe toggle-float, , Hide
return

; Pause responding to any window events or komorebic commands, Ctrl + Alt P
^!p::
Run, komorebic.exe toggle-pause, , Hide
return

; Switch to workspace
!1::
Send !
Run, komorebic.exe focus-workspace 0, , Hide
return

!2::
Send !
Run, komorebic.exe focus-workspace 1, , Hide
return

!3::
Send !
Run, komorebic.exe focus-workspace 2, , Hide
return

!4::
Send !
Run, komorebic.exe focus-workspace 3, , Hide
return

!5::
Send !
Run, komorebic.exe focus-workspace 4, , Hide
return

; Move window to workspace
!+1::
Run, komorebic.exe move-to-workspace 0, , Hide
return

!+2::
Run, komorebic.exe move-to-workspace 1, , Hide
return

!+3::
Run, komorebic.exe move-to-workspace 2, , Hide
return

!+4::
Run, komorebic.exe move-to-workspace 3, , Hide
return

!+5::
Run, komorebic.exe move-to-workspace 4, , Hide
return

!+i::
Run, komorebic.exe save ~/.config/komorebi/layouts/primary.json
return

!+m::
Run, komorebic.exe load ~/.config/komorebi/layouts/primary.json
return

#+o::
Run, komorebic.exe reload-configuration, , Hide
return

#+k:: Reload
return

^#+k::
Run, komorebic.exe stop
exitapp
