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
  ; NOTE: make sure spotify is not the topmost window and tha keys work before switcing to another desktop.
  ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
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
  ; DetectHiddenWindows, Off
  spotify = ahk_exe spotify.exe
  if WinExist(spotify) {
    if WinActive(spotify) {
      WinHide, %spotify%
      Send !{tab}
      ; NOTE: after hiding spotify and the current window is maximized,
      ; the keys won't work until you unmaximize the window.
      ; or we can send an empty key here.
      ControlFocus, Chrome_RenderWidgetHostHWND1, %spotify%
      ControlSend, ahk_parent, "", %spotify%
    } else {
      WinShow, %spotify%
      WinActivate, %Spotify%
      ; NOTE: if the current window is maximized when we press #s spotify's window
      ; gets stuck so we click somewhere on the window
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
