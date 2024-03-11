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

MoveWindowToCurrentDesktop() {
  global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
}

MoveCurrentWindowToDesktop(number) {
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
  global GoToDesktopNumberProc
  DllCall(GoToDesktopNumberProc, "Int", num, "Int")
  return
}
MoveOrGotoDesktopNumber(num) {
  ; If user is holding down Mouse left button, move the current window also
  if (GetKeyState("LButton")) {
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

!8:: PinWindow()
; !7:: UnPinWindow()

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

; goto previous desktop
OldDesktop := 0
!;:: GotoDesktopNumber(OldDesktop - 1)

!9:: GoToPrevDesktop()
!0:: GoToNextDesktop()

!1:: GotoDesktopNumber(0)
!2:: GotoDesktopNumber(1)
!3:: GotoDesktopNumber(2)
!4:: GotoDesktopNumber(3)
!5:: GotoDesktopNumber(4)

!+1:: MoveCurrentWindowToDesktop(0)
!+2:: MoveCurrentWindowToDesktop(1)
!+3:: MoveCurrentWindowToDesktop(2)
!+4:: MoveCurrentWindowToDesktop(3)
!+5:: MoveCurrentWindowToDesktop(4)

!r:: reload
