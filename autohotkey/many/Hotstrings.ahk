;#Hotstring EndChars -()[]{}:;'"/\,.?!`n `t

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Hotstrings ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

:R*?:date;::
FormatTime, CurrentDateTime,, MM-dd-yy
SendInput %CurrentDateTime%
return
:R*?:time;::
FormatTime, CurrentDateTime,, HH:mm
SendInput %CurrentDateTime%
return
:R*?:dtime;::
FormatTime, CurrentDateTime,, dd-MM-yy HH:mm
SendInput %CurrentDateTime%
return

:*:ahk;::AutoHotkey
:*:js;::javascript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; File Paths ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

:*:pd;::`%ProgramData`%
:*:ad;::`%AppData`%
