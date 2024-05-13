CoordMode, Mouse, Screen
EnvGet, MyUserProfile, USERPROFILE
Middle_Of_Screen := A_ScreenHeight /4
Screen_Near := A_screenWidth*0.8
kuan := A_screenWidth*0.88
+Esc::Send ~
; Initialized
; ----Capslock 切换第二键盘模式的快捷键 ----
!Capslock::
Second_mode := !Second_mode
ToolTip, Second_mode is %Second_mode%
sleep 3000
ToolTip
return

Quick_Open:
!n::
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
run, wt.exe -d "%MyUserProfile%\Downloads"
}
Return

Notification_Tray:
#x::
If (WinExist("ahk_class NotifyIconOverflowWindow"))
{
	Winhide, ahk_class NotifyIconOverflowWindow
}
else
{
	Winshow, ahk_class NotifyIconOverflowWindow
	WinMove, ahk_class NotifyIconOverflowWindow, ,%kuan%
}
Return

; ----以下为鼠标右键相关的代码-----
~*RButton::
Action := 0
mousegetpos ,xpos1,ypos1
if (ypos1 <= 1) {
    if (xpos1 >= Screen_Near) {
        Action := 1
	    if (xpos1 >= A_screenWidth-10) { ; 当鼠标在屏幕最右边时按下右键
	    	Send, #n
	    } else {
            Send, #a
	    }

    }
    if (xpos1 <= 10) { ; 当鼠标在屏幕最左边时按下右键
        Action := 1
        run, %MyUserProfile%\Favorites
    }
}
return

#if ypos1 <= 3
Rbutton up:: ; 鼠标手势
mousegetpos ,xpos2,ypos2
yValue:= ypos2-ypos1
xValue := xpos1-xpos2
; ToolTip, yValue is %Action%.
if (xValue <= -100)  { ; 按住右键向右滑动时
    if (xpos1 >= Screen_Near) {
        Goto, Notification_Tray
        Return
    } else {
        WinMinimizeAll
        sleep 150
        send {Escape}
        KeyWait, LButton, D
        sleep 500
        WinMinimizeAllUndo
        return
    }
} else if (xValue >= 120)  { ; 按住右键向左滑动时
	whichdesk := !whichdesk
	if Whichdesk = 1	
	{
        send #^{Left}
	} else {
        send #^{Right}
	}
	Return
} else if (yValue >= 10) { ; 按住右键向下滑动时
    if (yValue <= Middle_Of_Screen) {
        Send #{Tab}
        Return
    } else {
        Send {LWin}
        Return
    }
}
mousegetpos ,xpos1,ypos1
return

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