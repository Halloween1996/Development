CoordMode, Mouse, Screen
EnvGet, MyUserProfile, USERPROFILE
Menu, Tray, Add, 显示\隐藏 时间窗口, hidewindow
Menu, Tray, Add, 更改时间窗口的显示位置, Change_Time_Position
Menu, Tray, Add, 选取时间窗口的显示颜色, Change_Time_Color
Menu, Tray, Add, 修改配置文件, Open_InI_File
Menu, Tray, Add, 重置配置文件, NewUser
Menu, tray, Default, 更改时间窗口的显示位置
; ---初始化参数---
Initialize:
Screen_Near := A_screenWidth*0.85
Color_Changing := 0
Second_mode_Status := ""
Middle_Of_Screen := A_ScreenHeight /4
Screen_Near := A_screenWidth*0.8
Screen_Near_2 := A_screenWidth*0.9
IniRead, xx, %A_ScriptDir%\Pop-Up_Time.ini, Position, xx
if xx is not number 
	Goto, NewUser
IniRead, yy, %A_ScriptDir%\Pop-Up_Time.ini, Position, yy
IniRead, Time_Format_To_Show, %A_ScriptDir%\Pop-Up_Time.ini, Pop-Up_Time_Setting, Time_Format_To_Show
IniRead, Time_Color_To_Show, %A_ScriptDir%\Pop-Up_Time.ini, Pop-Up_Time_Setting, Time_Color_To_Show
If (yy <= Middle_Of_Screen) { 
	UorL := A_ScreenHeight*0.08 ;当Pop-up Time 的显示位置处于屏幕上方时，图标托盘的显示高度。
} else {
	UorL := A_ScreenHeight*0.70 ;当Pop-up Time 的显示位置处于屏幕下方时，图标托盘的显示高度。
}
Showup:
FormatTime, Timestr, Time, %Time_Format_To_Show%
Gui, Timar: Color, EEAA99
Gui, Timar: Font, s18 w700 c%Time_Color_To_Show%, Ink Free ; pop-up Time 字体相关
Gui, Timar: Add, Text,vTi w240 gChange_Time_Position, %Timestr%
Gui Timar: -Caption +ToolWindow +AlwaysOnTop +LastFound
WinSet, TransColor, EEAA99
Gui, Timar: Show, x%xx% y%yy%, PopUp_ShowTime
SetTimer, Update, 5000
SetTimer, WatchActiveWindow, 1200 ; 如果不想隐藏任务栏，删除下面的功能代码之余，还请删除这条代码
Return

Update:
FormatTime, Timestr, Time, %Time_Format_To_Show%
GuiControl, Timar: Text, Ti,%Second_mode_Status% %Timestr%
Gui Timar: +AlwaysOnTop
Return

; ----以上为Pop-Up Time 核心代码----
WatchActiveWindow:
MouseGetPos, xpos0, ypos0, 
WinGetClass, class, ahk_id %win%
If (ypos0 >= 200) {
	WinHide, ahk_class Shell_TrayWnd
	WinHide, Start ahk_class Button
}
If (ypos0 <= 1 and GetKeyState("LButton","P") = 1) { ;在屏幕最顶端长按不动时，显示任务栏
	if (xpos0 <= 15) { ; 当鼠标在屏幕最左边长按左键
		run, %MyUserProfile%\SynologyDrive\Ref\Present
		Return
	}
	sleep 300
	MouseGetPos, Detect_xpos,,
	If (ypos0 <= 1 and Detect_xpos == xpos0 and GetKeyState("LButton","P") = 1) {
		WinShow, ahk_class Shell_TrayWnd
		WinShow, Start ahk_class Button
	}
}
Return
; ----以上为：“鼠标位置不位于屏幕上方时，就自动隐藏任务栏”的功能代码----
; ----快捷键隐藏Pop-up TIme ----
^\::
hidewindow:
show := !show
If (WinExist("PopUp_ShowTime")) {
	Gui, Timar: Destroy
}else{
	Gosub showup
}
Return
; ----Capslock 切换第二键盘模式的快捷键，不需要可以移除以下代码 ----
+Esc::Send ~
Capslock::Return
!Capslock::
Second_mode := !Second_mode
If (Second_mode = 1) {
	ToolTip, Second_mode is on.
} else {
	ToolTip
}
sleep 3000
Send, {Capslock}
Return
；--------

Quick_Open:
~space & f::
IfWinActive, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
{
	WinHide, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
} Else {
	Winshow, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
	WinActivate, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}
Process,Exist,WindowsTerminal.exe
if (!ErrorLevel)
{
run, wt.exe -d "C:\Users\Halloween\Downloads"
}
Return

; ----以下为鼠标右键相关的代码-----
~*RButton::
mousegetpos ,xpos1,ypos1
if (ypos1 <= 1) {
    if (xpos1 >= Screen_Near_2) {
	    if (xpos1 >= A_screenWidth-10) { ; 当鼠标在屏幕最右边时按下右键
	    	Send, #n
	    } else {
            Send, #a
	    }
	}
	if (xpos1 = 0) { ; 当鼠标在屏幕最左边时按下右键
		run, %MyUserProfile%\SynologyDrive\Ref\Present
		Return
	}
	Winshow, ahk_class Shell_TrayWnd
	Winshow, Start ahk_class Button
	WinActivate, ahk_class Shell_TrayWnd
}
return

#if ypos1 <= 1
Rbutton up:: ; 鼠标手势
mousegetpos ,xpos2,ypos2
yValue:= ypos2-ypos1
xValue := xpos1-xpos2
if (xValue <= -100)  { ; 按住右键向右滑动时
	WinMinimizeAll
	sleep 150
	send {Escape}
	KeyWait, LButton, D
	sleep 500
	WinMinimizeAllUndo
	return
} else if (xValue >= 100)  { ; 按住右键向左滑动时
	whichdesk := !whichdesk
	if Whichdesk = 1	
	{
        send #^{Left}
	} else {
        send #^{Right}
	}
	Return
} else if (yValue >= 10) { ; 按住右键向下滑动时
	; Msgbox, y-value is %yValue%
    if (yValue <= Middle_Of_Screen) {
        Send #{Tab}
    } else {
        Send {LWin}
    }
	Return
}
mousegetpos ,xpos1,ypos1
return
; ----以下为ini配置文件读写相关的代码-----
Change_Time_Color:
Color_Changing := 1
Change_Time_Position:
Msgbox , 0, One more step! Click it!, 接下来，在该窗口消失后，请点击鼠标左键，选择新的时间显示位置或者Pop-up Time的显示颜色。, 0.5
KeyWait, LButton, D
mousegetpos ,xpos3,ypos3
Sleep 500
If (Color_Changing == 0) {
	IniWrite,% xpos3 - 30, %A_ScriptDir%\Pop-Up_Time.ini, Position, xx
	IniWrite,% ypos3 - 30, %A_ScriptDir%\Pop-Up_Time.ini, Position, yy
} else {
	PixelGetColor, Time_Color_To_Show, xpos3, ypos3, RGB
	Msgbox , 0, 颜色已确定, RGB 代码为：%Time_Color_To_Show%。, 1
	IniWrite,%Time_Color_To_Show%, %A_ScriptDir%\Pop-Up_Time.ini, Pop-Up_Time_Setting, Time_Color_To_Show
}
Color_Changing := 0
Goto, Refresh_UI

NewUser:
	IniWrite,% A_screenWidth*0.87, %A_ScriptDir%\Pop-Up_Time.ini, Position, xx
	IniWrite,6, %A_ScriptDir%\Pop-Up_Time.ini, Position, yy
	IniWrite,h:mm_ss tt, %A_ScriptDir%\Pop-Up_Time.ini, Pop-Up_Time_Setting, Time_Format_To_Show
	IniWrite,176AD7, %A_ScriptDir%\Pop-Up_Time.ini, Pop-Up_Time_Setting, Time_Color_To_Show
Goto, Refresh_UI

Open_InI_File:
RunWait, %A_ScriptDir%\Pop-Up_Time.ini
sleep, 500
Refresh_UI:
Gui, Timar: Destroy
Goto, Initialize

#If GetKeyState("RButton", "P") = 1 ; 按住鼠标右键时，滚轮调整音量
WheelUp:: Send {volume_up}
WheelDown:: Send {volume_down}
return
; ----Capslock 切换第二键盘模式的快捷键映射----
#IF (GetKeyState("Capslock", "P")) OR (Second_mode = 1)
w::Send {Up}
s::Send {Down}
a::Send {Left}
d::Send {Right}
f::Send {Right}
v::Send {Media_Next}
c::Send {Media_Prev}
x::Send {Media_Play_Pause}
e::Send {PgUp}
r::Send {PgDn}
1::Send {F11}
2::Send {F2}
3::Send {F3}
4::Send {F4}
5::Send {F5}
6::Send {S6}
7::Send {F7}
8::Send {F8}
9::Send {F9}
0::Send {F10}
o::9
i::8
u::7
l::6
k::5
j::4
.::3
,::2
m::1
n::1
space::0