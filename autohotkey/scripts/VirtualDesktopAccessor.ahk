; https://github.com/Ciantic/VirtualDesktopAccessor
#Requires AutoHotkey v2.0
SetWorkingDir(A_ScriptDir)

; Path to the DLL, relative to the script
VDA_PATH := A_ScriptDir . "./VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetCurrentDesktopNumber", "Ptr")
IsWindowOnCurrentVirtualDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsWindowOnCurrentVirtualDesktop", "Ptr")
IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsWindowOnDesktopNumber", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")
PinWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "PinWindow", "Ptr")
UnPinWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "UnPinWindow", "Ptr")
IsPinnedWindowProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "IsPinnedWindow", "Ptr")
GetDesktopNameProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopName", "Ptr")
SetDesktopNameProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "SetDesktopName", "Ptr")
CreateDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "CreateDesktop", "Ptr")
RemoveDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "RemoveDesktop", "Ptr")

; On change listeners
RegisterPostMessageHookProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "RegisterPostMessageHook", "Ptr")
UnregisterPostMessageHookProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "UnregisterPostMessageHook", "Ptr")

GetDesktopCount() {
  global GetDesktopCountProc
  count := DllCall(GetDesktopCountProc, "Int")
  return count
}

MoveCurrentWindowToDesktop(number) {
  global GetCurrentDesktopNumberProc
  current := DllCall(GetCurrentDesktopNumberProc, "Int")
  if (WinExist("A") && current != number) {
    global MoveWindowToDesktopNumberProc
    activeHwnd := WinGetID("A")
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", number, "Int")
    ; Send("!{Esc}") ; ALT+Esc activates last window(doesn't work with MoveWindowToCurrentDesktop)
    MsgBox("",,"T0.001") ; show msgbox for 1ms (works with MoveWindowToCurrentDesktop)
  }
}

MoveCurrentWindowAndGoToDesktop(number) {
  global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
  activeHwnd := WinGetID("A")
  DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", number, "Int")
  DllCall(GoToDesktopNumberProc, "Int", number, "Int")
}

GoToPrevDesktop() {
  global GetCurrentDesktopNumberProc, GoToDesktopNumberProc
  current := DllCall(GetCurrentDesktopNumberProc, "Int")
  last_desktop := GetDesktopCount() - 1
  ; If current desktop is 0, go to last desktop
  if (current = 0) {
    MoveOrGotoDesktopNumber(last_desktop)
  } else {
    MoveOrGotoDesktopNumber(current - 1)
  }
  return
}

GoToNextDesktop() {
  global GetCurrentDesktopNumberProc, GoToDesktopNumberProc
  current := DllCall(GetCurrentDesktopNumberProc, "Int")
  last_desktop := GetDesktopCount() - 1
  ; If current desktop is last, go to first desktop
  if (current = last_desktop) {
    MoveOrGotoDesktopNumber(0)
  } else {
    MoveOrGotoDesktopNumber(current + 1)
  }
  return
}

GoToDesktopNumber(num) {
  sleep 10 ; fix losing focus when switching desktops
  global GoToDesktopNumberProc
  DllCall(GoToDesktopNumberProc, "Int", num, "Int")
  return
}
MoveOrGotoDesktopNumber(num) {
  ; If user is holding down Shift, move the current window and go to desktop
  if (GetKeyState("Shift")) {
    MoveCurrentWindowAndGoToDesktop(num)
  } else if (GetKeyState("Ctrl"))  {
    MoveCurrentWindowToDesktop(num)
  } else {
    GoToDesktopNumber(num)
  }
  return
}
GetDesktopName(num) {
  global GetDesktopNameProc
  utf8_buffer := Buffer(1024, 0)
  ran := DllCall(GetDesktopNameProc, "Int", num, "Ptr", utf8_buffer, "Ptr", utf8_buffer.Size, "Int")
  name := StrGet(utf8_buffer, 1024, "UTF-8")
  return name
}
SetDesktopName(num, name) {
  global SetDesktopNameProc
  OutputDebug(name)
  name_utf8 := Buffer(1024, 0)
  StrPut(name, name_utf8, "UTF-8")
  ran := DllCall(SetDesktopNameProc, "Int", num, "Ptr", name_utf8, "Int")
  return ran
}
CreateDesktop() {
  global CreateDesktopProc
  ran := DllCall(CreateDesktopProc, "Int")
  return ran
}
RemoveDesktop(remove_desktop_number, fallback_desktop_number) {
  global RemoveDesktopProc
  ran := DllCall(RemoveDesktopProc, "Int", remove_desktop_number, "Int", fallback_desktop_number, "Int")
  return ran
}

PinWindow() {
  activeHwnd := WinGetID("A")
  global PinWindowProc
  ran := DllCall(PinWindowProc, "Int", activeHwnd, "Int")
  return ran
}

UnPinWindow() {
  activeHwnd := WinGetID("A")
  global UnPinWindowProc
  ran := DllCall(UnPinWindowProc, "Int", activeHwnd, "Int")
  return ran
}

TogglePinWindow() {
  activeHwnd := WinGetID("A")
  global IsPinnedWindowProc
  isPinned := DllCall(IsPinnedWindowProc, "Int", activeHwnd, "Int")
  if (isPinned) {
    UnPinWindow()
    Tooltip("unpinned", 0, 0)
  } else {
    PinWindow()
    Tooltip("pinned", 0, 0)
  }
  SetTimer () => ToolTip(), -500
}

MoveWindowToCurrentDesktop(window) {
  DetectHiddenWindows("On")
  if (WinExist(window)) {
    hwnd := WinGetID(window)
    global GetCurrentDesktopNumberProc, MoveWindowToDesktopNumberProc
    current := DllCall(GetCurrentDesktopNumberProc, "Int")
    DllCall(MoveWindowToDesktopNumberProc, "Ptr", hwnd, "Int", current, "Int")
    WinActivate(window)
  }
}

; SetDesktopName(0, "It works! 🐱")
DllCall(RegisterPostMessageHookProc, "Ptr", A_ScriptHwnd, "Int", 0x1400 + 30, "Int")
OnMessage(0x1400 + 30, OnChangeDesktop)
OnChangeDesktop(wParam, lParam, msg, hwnd) {
  Critical(1)
  global OldDesktop := wParam + 1
  NewDesktop := lParam + 1
  Name := GetDesktopName(NewDesktop - 1)

  ; Use Dbgview.exe to checkout the output debug logs
  ; OutputDebug("Desktop changed to " Name " from " OldDesktop " to " NewDesktop)
  ; TraySetIcon(".\Icons\icon" NewDesktop ".ico")
}

; NOTE: when tapping alt then space mpv opens the context menu of the window's title bar even if alt-space is remapped.
; use `Alt &` instead of `!` because when switching to a desktop that has mpv focused the above bug happens.
; also `GetKeyState("Shift")` doesn' work with `!`

; goto previous desktop
OldDesktop := 0
Alt & `;:: MoveOrGotoDesktopNumber(OldDesktop - 1)

Alt & 9:: GoToPrevDesktop()
Alt & 0:: GoToNextDesktop()
Alt & 1:: MoveOrGotoDesktopNumber(0)
Alt & 2:: MoveOrGotoDesktopNumber(1)
Alt & 3:: MoveOrGotoDesktopNumber(2)
Alt & 4:: MoveOrGotoDesktopNumber(3)
Alt & 5:: MoveOrGotoDesktopNumber(4)

!8:: TogglePinWindow()
!7:: MoveWindowToCurrentDesktop("ahk_exe alacritty.exe")

; !r:: reload
