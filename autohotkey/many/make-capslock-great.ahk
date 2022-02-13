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
;|CaspLock + {F1}~{F8}  | Media Volume Controller                     |
;|CapsLock + qs         | Windows & Tags Control                      |
;-----------------------o---------------------------------------------o
;|Use it whatever and wherever you like. Hope it help                 |
;=====================================================================o

;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff
;---------------------------------------------------------------------o

;=====================================================================o
;                       CapsLock Switcher:                           ;|
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       ;|
;---------------------------------o-----------------------------------o
CapsLock & `;::
GetKeyState, CapsLockState, CapsLock, T
if CapsLockState = D
  SetCapsLockState, AlwaysOff
else
  SetCapsLockState, AlwaysOn
KeyWait, F8
return
;---------------------------------------------------------------------o

;=====================================================================o
;                         CapsLock Escaper:                          ;|
;----------------------------------o----------------------------------o
;                        CapsLock  |  {ESC}                          ;|
;----------------------------------o----------------------------------o
CapsLock::Send, {ESC}
+CapsLock::Send, +{ESC}
;---------------------------------------------------------------------o

;=====================================================================o
;                    CapsLock Direction Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + h |  Left                          ;|
;                      CapsLock + j |  Down                          ;|
;                      CapsLock + k |  Up                            ;|
;                      CapsLock + l |  Right                         ;|
;                      CapsLock + i |  Home                          ;|
;                      CapsLock + o |  End                           ;|
;                      CapsLock + u |  PageUp                        ;|
;                      CapsLock + p |  PageDown                      ;|
;-----------------------------------o---------------------------------o
; this needs to be above CapsLock & j and CapsLock & k
; !j::
;   if (not GetKeyState("Control") and not getKeyState("Shift"))
;     Send, {ALTDOWN}{TAB}ALTUP}
; return

; !k::
;   if (not GetKeyState("Control") and not getKeyState("Shift"))
;     Send, {ALTDOWN}{SHIFTDOWN}{TAB}{SHIFTUP}ALTUP}
; return

CapsLock & k::Up
CapsLock & j::Down
CapsLock & h::Left
CapsLock & l::Right
CapsLock & i::Home
CapsLock & o::End
CapsLock & u::PgUp
CapsLock & p::PgDn
;---------------------------------------------------------------------o

;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + n  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + m  |  Delete                        ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + .  |  Ctrl + BackSpace              ;|
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del}
CapsLock & .:: Send, ^{Del}
CapsLock & m:: Send, {BS}
CapsLock & n:: Send, ^{BS}
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
; Unmute
; CapsLock & c:: Run nircmd.exe mutesysvolume 0 microphone
; Return
; Mute
; CapsLock & x:: Run nircmd.exe mutesysvolume 1 microphone
; Return
; Toggle
CapsLock & z:: Run nircmd.exe mutesysvolume 2 microphone
Return
;CapsLock & v:: Send, !d neovide.exe --geometry=200x56{Enter}
;               Return
CapsLock & a:: Send, ^a
CapsLock & y:: Send, ^y
CapsLock & w:: Send, ^{Right}
CapsLock & b:: Send, ^{Left}
CapsLock & c:: Send, ^{c}
CapsLock & v:: Send, ^{v}
CapsLock & s:: Shift
CapsLock & d:: Ctrl
CapsLock & f:: Send, {Esc}
CapsLock & [:: Send, {Esc}
CapsLock & ]:: Send, {insert}
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
CapsLock & F2:: Send, {Volume_Down}
CapsLock & F3:: Send, {Volume_Up}
CapsLock & F4:: Send, {Media_Mute}
CapsLock & F5:: Send, {Media_Play_Pause}
CapsLock & F6:: Send, {Media_Stop}
CapsLock & F7:: Send, {Media_Prev}
CapsLock & F8:: Send, {Media_Next}
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
CapsLock & r::Send, ^{Tab}
CapsLock & e::Send, ^+{Tab}
CapsLock & q::
  if GetKeyState("alt") = 0
  {
    Send, ^w
  }
  else {
    Send, !{F4}
    return
  }
return
CapsLock & g:: Send, {AppsKey}
;---------------------------------------------------------------------o

;=====================================================================o
;                        CapsLock Self Defined Area                  ;|
;-----------------------------------o---------------------------------o
CapsLock & 0:: ; switch to next desktop
  Send, #^{Right}
Return

CapsLock & 9:: ; switch to previous desktop
  Send, #^{Left}
Return
;---------------------------------------------------------------------o
