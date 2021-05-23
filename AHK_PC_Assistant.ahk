tbar := 1
lashow := 1

^t::
tbar := !tbar
WinSet, AlwaysOnTop, toggle,A
if (tbar = 0){
	WinSet, Style, -0xC00000, A 
}else{
	WinSet, Style, +0xC00000, A
}
Return

^space:: 
lashow := !lashow
if (lashow = 0){
	WinHide, quick_Launcing_CMD
}else{
	Winshow, quick_Launcing_CMD
	WinActivate ,quick_Launcing_CMD
}
return
  
+space::
return

#IfWinActive ahk_class CabinetWClass ; If Windows Explorer window is active
PrintScreen::
SendInput, ^c
Sleep 100
cl := Clipboard
stringreplace,cl,cl,%a_space%,`%20,all
stringreplace,cl,cl,\\,//,1 
clipboard=%cl%
msgbox , , I got the file path!, %cl%, 1
Return

