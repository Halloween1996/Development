CoordMode, Mouse, Screen
Menu, tray, Add, disable\Enable guestures, guestures
Menu, tray, Add, Hide\show window, hidewindow
Menu, tray, default, Hide\show window
Menu, tray, Click, 1
Menu, Tray, Icon, C:\15th\Icons\fast_time.ico
Rclick := 1
x := A_screenWidth
kuan := x*0.89
Noti := x*0.85
Left := x*0.05

Showup:
FormatTime, Timestr,, Time
Gui, Color, EEAA99
Gui, Font, s18 w700 c176AD7, Ink Free
Gui, Add, Text,vTi w120 gWinkey, %Timestr%
Gui +ToolWindow +AlwaysOnTop +LastFound
WinSet, TransColor, EEAA99
Gui -Caption
Gui, Show,x%kuan% y6, PopUp_ShowTime
SetTimer, Update, 700
SetTimer, WatchActiveWindow, 1000
Return

Update:
FormatTime, Timestr,, Time
GuiControl,,Ti,%Timestr%
Gui +ToolWindow +AlwaysOnTop
Return

WatchActiveWindow:
MouseGetPos, xpos0, ypos0, 
If (ypos0>= 70) {
	WinHide, ahk_class Shell_TrayWnd
	WinHide, Start ahk_class Button
}
return

^\::
hidewindow:
show := !show
If (WinExist("PopUp_ShowTime")) {
	Gui,Destroy
}else{
	Gosub showup
}
Return

Winkey:
If (WinExist("ahk_class NotifyIconOverflowWindow")) {
	Winhide, ahk_class NotifyIconOverflowWindow
}else{
	Winshow, ahk_class NotifyIconOverflowWindow
	WinMove, ahk_class NotifyIconOverflowWindow, ,%Noti%, 75
}
return

^r::
guestures:
Rclick := !Rclick
if (Rclick= 0) {
	MsgBox, 16, right click guestures is no longger work!, guestures is disable now, 1
} else {
	Msgbox, 48, right click guestures work now, right click guestures is working right now, 1
}
return

#If (Rclick = 1)
Rbutton::
mousegetpos ,xpos1,ypos1
if (ypos1<=1) {
	Winshow, ahk_class Shell_TrayWnd
	Winshow, Start ahk_class Button
} else {
	Click, Right
}
return

Rbutton up::
mousegetpos ,xpos2,ypos2
yValue:= ypos1-ypos2
if (yValue>=150) { ; 右键向上时
	WinShow, ahk_class Shell_TrayWnd
	WinShow, Start ahk_class Button
	Send {LWin}
}else if (yValue<=-150)  { ; 右键向下时
	send {alt down}{tab}
	KeyWait, LButton, D
	Send {LButton}
	sleep 20
	send {alt up}
}
return

#If GetKeyState("RButton", "P") = 1
WheelUp:: Send {volume_up}
WheelDown:: Send {volume_down}
return