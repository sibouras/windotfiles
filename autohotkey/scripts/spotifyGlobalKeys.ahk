#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
; https://www.reddit.com/r/AutoHotkey/comments/orzend/spotify_global_hotkeys/
DetectHiddenWindows, On

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
  WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
  Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
  spotifyHwnd := getSpotifyHwnd()
  ; Chromium ignores keys when it isn't focused.
  ; Focus the document window without bringing the app to the foreground.
  ; NOTE: ControlClick just works unlike ControlFocus
  ; `U` to release the mouse button and prevent focusing the window when spamming the keys.
  ControlClick, x500 y100, ahk_id %spotifyHwnd%, , Left, 1, U
  ControlSend, ahk_parent, %key%, ahk_id %spotifyHwnd%
}

#6::spotifyKey("!+{b}") ; like song
#=::spotifyKey("{Space}") ; play/pause
#0::spotifyKey("^{Right}") ; next
#9::spotifyKey("^{Left}") ; previous
#8::spotifyKey("+{Right}") ; Seek forward
#7::spotifyKey("+{Left}") ; Seek backward
#k::spotifyKey("^{Up}") ; Volume up
#j::spotifyKey("^{Down}") ; Volume down

#s::
  spotify = ahk_exe spotify.exe
  if WinExist(spotify) {
    if WinActive(spotify) {
      WinHide, %spotify%
      Send !{tab}
    } else {
      WinShow, %spotify%
      WinActivate, %Spotify%
      ; NOTE: if the current window is maximized when we activate spotify,
      ; spotify's window gets stuck so we click somewhere on the window
      ControlClick, x500 y100, %spotify%
    }
  }
return

; for debug: get ClassNN
; F1::
; 	WinGet, classNNlist, ControlList, A
; 	MsgBox, % classNNlist
; return

; !f::reload
