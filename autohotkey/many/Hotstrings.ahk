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

/*
::currdate::
	FormatTime, today, A_Now, M/d/yyyy
	Sleep, 100 ; Needed for VS Code
	SendInput, %today%
	Return
::currtime::
	FormatTime, now, A_Now, h:mmtt
	Sleep, 100 ; Needed for VS Code
	Send % now
	Return
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; File Paths ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

:*:pd;::`%ProgramData`%
:*:ad;::`%AppData`%
