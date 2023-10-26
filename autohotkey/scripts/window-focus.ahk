; from: https://github.com/RamonUnch/AltSnap/issues/465#issuecomment-1731454298
; source: https://github.com/lpke/config/blob/master/ahk/window-focus.ahk
#Requires AutoHotkey v2.0

calc_padding := -10 ; minimum direction/alignment overlap for target windows

!h:: FocusWin("left")
!l:: FocusWin("right")
!k:: FocusWin("up")
!j:: FocusWin("down")

; ==== DEVELOPMENT SHORTCUTS ====
; Reload this script
#+r:: {
  Reload
}
; Get active window position data
#+t:: {
  aID := WinGetID("A")
  wclass := WinGetClass(aID)
  WinGetFullPos(&aXL, &aXR, &aYT, &aYB, &aW, &aH, aID)
  discounted := WinIsDiscounted(aID, &visible, &desktop, &taskbar, &startmenu)

  MsgBox(
    "class:  " wclass "`n"
    "XL:  " aXL "`n"
    "XR:  " aXR "`n"
    "YT:  " aYT "`n"
    "YB:  " aYB "`n"
    "W:  "  aW  "`n"
    "H:  "  aH  "`n"
    "`n"
    "ID:  " aID "`n"
    "`n"
    "Visible:  " visible "`n"
    "Desktop:  " desktop "`n"
    "Taskbar:  " taskbar "`n"
    "Startmenu:  " startmenu "`n"
    "`n"
    "Discounted:  " discounted
  )
}

WinGetFullPos(&xl, &xr, &yt, &yb, &w, &h, id) {
  WinGetPos(&xl, &yt, &w, &h, id)
  xr := xl + w
  yb := yt + h
  return
}

OverlapAxis(axis, padding, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB) {
  if (axis = "Y" && (tYB >= (aYT + padding) && (tYT + padding) <= aYB))
    return true
  if (axis = "X" && (tXR >= (aXL + padding) && (tXL + padding) <= aXR))
    return true
  return false
}

WinIsDiscounted(id, &visible, &desktop, &taskbar, &startmenu) {
  wclass := WinGetClass(id)
  wstyle := WinGetStyle("ahk_id" id)
  WS_VISIBLE := 0x10000000

  visible := (wstyle & WS_VISIBLE) ? true : false
  desktop := (wclass = "Progman" || wclass = "WorkerW" || wclass = "ApplicationManager_ImmersiveShellWindow")
  taskbar := (wclass = "Shell_TrayWnd" || wclass = "Shell_SecondaryTrayWnd")
  startmenu := (wclass = "DV2ControlHost" || wclass = "Windows.UI.Core.CoreWindow")

  return !visible || desktop || taskbar || startmenu
}

FocusWin(direction) {
  aID := WinGetID("A") ; get ID of active window
  WinGetFullPos(&aXL, &aXR, &aYT, &aYB, &aW, &aH, aID) ; get pos/size of active window

  ids_arr := WinGetList() ; get all window IDs (returns array of id strings)

  ; values to update during the loop
  closest_id := ""
  closest_distance := 999999999

  ; loop through all windows
  ; validity checks are made early as possible for performance
  for (tID in ids_arr) {
    is_active_win := tID == aID
    if (is_active_win)
      continue
    is_discounted_win := WinIsDiscounted(tID, &visible, &desktop, &taskbar, &startmenu)
    if (is_discounted_win)
      continue

    WinGetFullPos(&tXL, &tXR, &tYT, &tYB, &tW, &tH, tID) ; get pos/size of target window

    switch direction
    {
      case "left": is_direction := aXL - tXL >= calc_padding
      case "right": is_direction := tXR - aXR >= calc_padding
      case "up": is_direction := aYT - tYT >= calc_padding
      case "down": is_direction := tYB - aYB >= calc_padding
    }
    if (!is_direction)
      continue
    switch direction
    {
      case "left": is_aligned := OverlapAxis("Y", calc_padding, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB)
      case "right": is_aligned := OverlapAxis("Y", calc_padding, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB)
      case "up": is_aligned := OverlapAxis("X", calc_padding, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB)
      case "down": is_aligned := OverlapAxis("X", calc_padding, aXL, aXR, aYT, aYB, tXL, tXR, tYT, tYB)
    }
    if (!is_aligned)
      continue

    switch direction
    {
      case "left": distance := aXL - tXR
      case "right": distance := tXL - aXR
      case "up": distance := aYT - tYB
      case "down": distance := tYT - aYB
    }

    ; update closest values if window is closer and to the left
    if (distance < closest_distance) {
      closest_id := tID
      closest_distance := distance
    }
  }

  ; activate closest window
  if (closest_id)
    WinActivate("ahk_id" closest_id)

  return
}
