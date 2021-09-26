#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;=====================================================================o
;                   Feng Ruohang's AHK Script                         |
;                      CapsLock Enhancement                           |
;---------------------------------------------------------------------o
;Description:                                                         |
;    This Script is wrote by Feng Ruohang via AutoHotKey Script. It   |
; Provieds an enhancement towards the "Useless Key" CapsLock, and     |
; turns CapsLock into an useful function Key just like Ctrl and Alt   |
; by combining CapsLock with almost all other keys in the keyboard.   |
;                                                                     |
;Summary:                                                             |
;o----------------------o---------------------------------------------o
;|CapsLock;             | {ESC}  Especially Convient for vim user     |
;|CaspLock + `          | {CapsLock}CapsLock Switcher as a Substituent|
;|CapsLock + hjklwb     | Vim-Style Cursor Mover                      |
;|CaspLock + uiop       | Convient Home/End PageUp/PageDn             |
;|CaspLock + nm,.       | Convient Delete Controller                  |
;|CapsLock + zxcvay     | Windows-Style Editor                        |
;|CapsLock + Direction  | Mouse Move                                  |
;|CapsLock + Enter      | Mouse Click                                 |
;|CaspLock + {F1}~{F6}  | Media Volume Controller                     |
;|CapsLock + qs         | Windows & Tags Control                      |
;|CapsLock + ;'[]       | Convient Key Mapping                        |
;|CaspLock + dfert      | Frequently Used Programs (Self Defined)     |
;|CaspLock + 123456     | Dev-Hotkey for Visual Studio (Self Defined) |
;|CapsLock + 67890-=    | Shifter as Shift                            |
;-----------------------o---------------------------------------------o
;|Use it whatever and wherever you like. Hope it help                 |
;=====================================================================o


;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff                                          ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                       CapsLock Switcher:                           ;|
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       ;|
;---------------------------------o-----------------------------------o
CapsLock & `;::                                                      ;|
GetKeyState, CapsLockState, CapsLock, T                              ;|
if CapsLockState = D                                                 ;|
    SetCapsLockState, AlwaysOff                                      ;|
else                                                                 ;|
    SetCapsLockState, AlwaysOn                                       ;|
KeyWait, F8                                                          ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                         CapsLock Escaper:                          ;|
;----------------------------------o----------------------------------o
;                        CapsLock  |  {ESC}                          ;|
;----------------------------------o----------------------------------o
CapsLock::Send, {ESC}                                                ;|
;---------------------------------------------------------------------o

;=====================================================================o
;                    CapsLock Direction Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + h |  Left                          ;|
;                      CapsLock + j |  Down                          ;|
;                      CapsLock + k |  Up                            ;|
;                      CapsLock + l |  Right                         ;|
;                      Ctrl, Alt Swapped                             ;|
;-----------------------------------o---------------------------------o
CapsLock & k::                                                       ;|
if GetKeyState("Shift", "D")                                         ;|
    if GetKeyState("Alt", "D")                                       ;|
        Send +^{Up}                                                  ;|
    else if GetKeyState("Ctrl", "D")                                 ;|
        Send +!{Up}                                                  ;|
    else                                                             ;|
        Send +{Up}                                                   ;|
else if GetKeyState("Ctrl", "D")                                     ;|
    if (GetKeyState("Alt", "D"))                                     ;|
        Send !^{Up}                                                  ;|
    else                                                             ;|
        Send !{Up}                                                   ;|
else if GetKeyState("Alt", "D")                                      ;|
    Send ^{Up}                                                       ;|
else                                                                 ;|
    Send {Up}                                                        ;|
return                                                               ;|
                                                                     ;|
CapsLock & j::                                                       ;|
if GetKeyState("Shift", "D")                                         ;|
    if GetKeyState("Alt", "D")                                       ;|
        Send +^{Down}                                                ;|
    else if GetKeyState("Ctrl", "D")                                 ;|
        Send +!{Down}                                                ;|
    else                                                             ;|
        Send +{Down}                                                 ;|
else if GetKeyState("Ctrl", "D")                                     ;|
    if (GetKeyState("Alt", "D"))                                     ;|
        Send !^{Down}                                                ;|
    else                                                             ;|
        Send !{Down}                                                 ;|
else if GetKeyState("Alt", "D")                                      ;|
    Send ^{Down}                                                     ;|
else                                                                 ;|
    Send {Down}                                                      ;|
return                                                               ;|
                                                                     ;|
CapsLock & h::                                                       ;|
if GetKeyState("Shift", "D")                                         ;|
    if GetKeyState("Alt", "D")                                       ;|
        Send +^{Left}                                                ;|
    else if GetKeyState("Ctrl", "D")                                 ;|
        Send +!{Left}                                                ;|
    else                                                             ;|
        Send +{Left}                                                 ;|
else if GetKeyState("Ctrl", "D")                                     ;|
    if (GetKeyState("Alt", "D"))                                     ;|
        Send !^{Left}                                                ;|
    else                                                             ;|
        Send !{Left}                                                 ;|
else if GetKeyState("Alt", "D")                                      ;|
    Send ^{Left}                                                     ;|
else                                                                 ;|
    Send {Left}                                                      ;|
return                                                               ;|
                                                                     ;|
CapsLock & l::                                                       ;|
if GetKeyState("Shift", "D")                                         ;|
    if GetKeyState("Alt", "D")                                       ;|
        Send +^{Right}                                               ;|
    else if GetKeyState("Ctrl", "D")                                 ;|
        Send +!{Right}                                               ;|
    else                                                             ;|
        Send +{Right}                                                ;|
else if GetKeyState("Ctrl", "D")                                     ;|
    if (GetKeyState("Alt", "D"))                                     ;|
        Send !^{Right}                                               ;|
    else                                                             ;|
        Send !{Right}                                                ;|
else if GetKeyState("Alt", "D")                                      ;|
    Send ^{Right}                                                    ;|
else                                                                 ;|
    Send {Right}                                                     ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock Home/End Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + i |  Home                          ;|
;                      CapsLock + o |  End                           ;|
;                      Ctrl, Alt Swapped
;-----------------------------------o---------------------------------o
CapsLock & i::                                                       ;|
if GetKeyState("Shift", "D")                                         ;|
    if GetKeyState("Alt", "D")                                       ;|
        Send +^{Home}                                                ;|
    else if GetKeyState("Ctrl", "D")                                 ;|
        Send +!{Home}                                                ;|
    else                                                             ;|
        Send +{Home}                                                 ;|
else if GetKeyState("Ctrl", "D")                                     ;|
    if (GetKeyState("Alt", "D"))                                     ;|
        Send !^{Home}                                                ;|
    else                                                             ;|
        Send !{Home}                                                 ;|
else if GetKeyState("Alt", "D")                                      ;|
    Send ^{Home}                                                     ;|
else                                                                 ;|
    Send {Home}                                                      ;|
return                                                               ;|
                                                                     ;|
CapsLock & o::                                                       ;|
if GetKeyState("Shift", "D")                                         ;|
    if GetKeyState("Alt", "D")                                       ;|
        Send +^{End}                                                 ;|
    else if GetKeyState("Ctrl", "D")                                 ;|
        Send +!{End}                                                 ;|
    else                                                             ;|
        Send +{End}                                                  ;|
else if GetKeyState("Ctrl", "D")                                     ;|
    if (GetKeyState("Alt", "D"))                                     ;|
        Send !^{End}                                                 ;|
    else                                                             ;|
        Send !{End}                                                  ;|
else if GetKeyState("Alt", "D")                                      ;|
    Send ^{End}                                                      ;|
else                                                                 ;|
    Send {End}                                                       ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                      CapsLock Page Navigator                       ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + u |  PageUp                        ;|
;                      CapsLock + p |  PageDown                      ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & u::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgUp}                                                 ;|
    else                                                             ;|
        Send, +{PgUp}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgUp}                                                ;|
    else                                                             ;|
        Send, +^{PgUp}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & p::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgDn}                                                 ;|
    else                                                             ;|
        Send, +{PgDn}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgDn}                                                ;|
    else                                                             ;|
        Send, +^{PgDn}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock Mouse Controller                      ;|
;-----------------------------------o---------------------------------o
;                   CapsLock + Up   |  Mouse Up                      ;|
;                   CapsLock + Down |  Mouse Down                    ;|
;                   CapsLock + Left |  Mouse Left                    ;|
;                  CapsLock + Right |  Mouse Right                   ;|
;    CapsLock + Enter(Push Release) |  Mouse Left Push(Release)      ;|
;-----------------------------------o---------------------------------o
; CapsLock & Up::    MouseMove, 0, -10, 0, R                         ;|
; CapsLock & Down::  MouseMove, 0, 10, 0, R                          ;|
; CapsLock & Left::  MouseMove, -10, 0, 0, R                         ;|
; CapsLock & Right:: MouseMove, 10, 0, 0, R                          ;|
;-----------------------------------o                                ;|
CapsLock & Enter::                                                   ;|
SendEvent {Blind}{LButton down}                                      ;|
KeyWait Enter                                                        ;|
SendEvent {Blind}{LButton up}                                        ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + n  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + m  |  Delete                        ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + .  |  Ctrl + BackSpace              ;|
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del}                                           ;|
CapsLock & .:: Send, ^{Del}                                          ;|
CapsLock & m:: Send, {BS}                                            ;|
CapsLock & n:: Send, ^{BS}                                           ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                            CapsLock Editor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + z  |  Ctrl + z (Cancel)             ;|
;                     CapsLock + x  |  Ctrl + x (Cut)                ;|
;                     CapsLock + c  |  Ctrl + c (Copy)               ;|
;                     CapsLock + v  |  Ctrl + z (Paste)              ;|
;                     CapsLock + a  |  Ctrl + a (Select All)         ;|
;                     CapsLock + y  |  Ctrl + z (Yeild)              ;|
;                     CapsLock + w  |  Ctrl + Right(Move as [vim: w]);|
;                     CapsLock + b  |  Ctrl + Left (Move as [vim: b]);|
;-----------------------------------o---------------------------------o
; Unmute                                                             ;|
; CapsLock & c:: Run nircmd.exe mutesysvolume 0 microphone           ;|
               ; Return                                              ;|
; Mute                                                               ;|
; CapsLock & x:: Run nircmd.exe mutesysvolume 1 microphone           ;|
               ; Return                                              ;|
; Toggle                                                             ;|
CapsLock & z:: Run nircmd.exe mutesysvolume 2 microphone             ;|
               Return                                                ;|
;CapsLock & v:: Send, ^v                                             ;|
;CapsLock & v:: Send, !d neovide.exe --geometry=200x56{Enter}        ;|
;               Return                                               ;|
; CapsLock & a:: Send, ^a                                            ;|
CapsLock & y:: Send, ^y                                              ;|
CapsLock & w:: Send, ^{Right}                                        ;|
CapsLock & b:: Send, ^{Left}                                         ;|
CapsLock & [:: Send, {insert}
;---------------------------------------------------------------------o


;=====================================================================o
;                       CapsLock Media Controller                    ;|
;-----------------------------------o---------------------------------o
;                    CapsLock + F2  |  Volume_Down                   ;|
;                    CapsLock + F3  |  Volume_Up                     ;|
;                    CapsLock + F4  |  Media_Mute                    ;|
;                    CapsLock + F5  |  Media_Play_Pause              ;|
;                    CapsLock + F6  |  Media_Stop                    ;|
;                    CapsLock + F7  |  Media_Prev                    ;|
;                    CapsLock + F8  |  Media_Next                    ;|
;-----------------------------------o---------------------------------o
CapsLock & F2:: Send, {Volume_Down}                                  ;|
CapsLock & F3:: Send, {Volume_Up}                                    ;|
CapsLock & F4:: Send, {Media_Mute}                                   ;|
CapsLock & F5:: Send, {Media_Play_Pause}                             ;|
CapsLock & F6:: Send, {Media_Stop}                                   ;|
CapsLock & F7:: Send, {Media_Prev}                                   ;|
CapsLock & F8:: Send, {Media_Next}                                   ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                      CapsLock Window Controller                    ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + s  |  Ctrl + Tab (Swith Tag)        ;|
;                     CapsLock + q  |  Ctrl + W   (Close Tag)        ;|
;   (Disabled)  Alt + CapsLock + s  |  AltTab     (Switch Windows)   ;|
;               Alt + CapsLock + q  |  Ctrl + Tab (Close Windows)    ;|
;                     CapsLock + g  |  AppsKey    (Menu Key)         ;|
;-----------------------------------o---------------------------------o
CapsLock & r::Send, ^{Tab}                                           ;|
CapsLock & e::Send, ^+{Tab}                                          ;|
;-----------------------------------o                                ;|
CapsLock & q::                                                       ;|
if GetKeyState("alt") = 0                                            ;|
{                                                                    ;|
    Send, ^w                                                         ;|
}                                                                    ;|
else {                                                               ;|
    Send, !{F4}                                                      ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & g:: Send, {AppsKey}                                       ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                        CapsLock Self Defined Area                  ;|
;-----------------------------------o---------------------------------o
CapsLock & 0:: ; switch to next desktop with Windows key + Left Alt key
  KeyWait LAlt
  SendInput #^{Right}
  Return

CapsLock & 9:: ; switch to previous desktop with Windows key + Left CTRL key
  KeyWait LCtrl
  SendInput #^{Left}
  Return
;---------------------------------------------------------------------o
