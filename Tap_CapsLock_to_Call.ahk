Menu, tray, Add, Active defined Window, Showup
Menu, tray, Add, Cancel to hide the window, Startup
Menu, tray, Add, Go Exit, menu4Exit
Menu, tray, default, Active defined Window
DetectHiddenWindows, On
^CapsLock::
startup:
If (WinId) {
	Winshow, ahk_id %WinId%
	WinMove, ahk_id %WinId%, , %WinIdx%, %WinIdy%
	WinId :=
} Else {
	WinGet, WinId, id, A
	WinGetPos, WinIdx, WinIdy, width, height, ahk_id %WinId%
	WinHide, ahk_id %WinId%
	Pin := 0
}
return

menu4Exit:
	Gosub, Startup
	ExitApp

CapsLock::
Showup:
IfWinActive, ahk_id %WinId%
{
	Pin := !Pin
} else {
	WinActivate, ahk_id %WinId%
}
If (Pin = 0) {
	WinHide, ahk_id %WinId%
} else {
	Winshow, ahk_id %WinId%
}
return