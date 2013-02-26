SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;Alt + q = Alt + F4
!q::Send {Alt down}{F4}{Alt up}
;Win + F = Ctrl + Alt + Shift + F
#F::
	SetKeyDelay -1
	Send ^+!F
return

F1::Send {Escape}
;定义RAlt + C 为打开日历
RAlt & c::
	Run https://www.google.com/calendar/renderOnline?tab=qc&gsessionid=OK
return
RAlt & m::
	Run https://mail.google.com/mail/u/0/?zx=beau3deb5n6x&shva=1#inbox
return
RAlt & n::
	Run http://net.tsinghua.edu.cn
return
RAlt & r::
	Run https://www.google.com/reader/view/#overview-page
return
RCtrl & l::
	Run http://learn.tsinghua.edu.cn
return
RAlt & p::
	Run https://mail.google.com/mail/u/0/#contacts
return
RAlt & s::
	Send ^c
	if (StrLen(clipboard) <> 0)
	Run https://www.google.com/search?hl=zh-CN&q=%clipboard%
return

RAlt & g::
	Run gvim.bat, D:/PATH
	WinWait [No Name] - GVIM
    WinActivate
return

;disable Right Alt Key
RAlt:: 
	return
;disable Right Ctrl Key
RCtrl:: return

$j::
	if (GetKeyState("ScrollLock", "T"))
		SendInput {Down}
	else
		SendRaw j
return
$k::
	if (GetKeyState("ScrollLock", "T"))
		SendInput {Up}
	else
		SendRaw k
return
$h::
	if (GetKeyState("ScrollLock", "T"))
		SendInput {Left}
	else
		SendRaw h
return
$l::
	if (GetKeyState("ScrollLock", "T"))
		SendInput {Right}
	else
		SendRaw l
return


;  disable Win + Enter
#Enter::
superMaximize()
return


/*
 * Super Maximizes the currently active window.
 */
superMaximize() {
	global

	WinActive("A")
	WinGet, winId, ID

	if (isSuperMaximized_%winId% = 1) {
		; already supermaximized: we restore the window
		WinSet, Style, +0x800000
		WinMove, , , orig_%winId%_x, orig_%winId%_y, orig_%winId%_width, orig_%winId%_height
		if (orig_%winId%_wasMaximized) {
			WinMaximize
		}
		isSuperMaximized_%winId% = 0
	} else {
		; not supermaximized: we supermaximize it
		WinGet, orig_%winId%_wasMaximized, MinMax
		if (orig_%winId%_wasMaximized = 1) {
			WinRestore
		}
		WinGetPos, orig_%winId%_x, orig_%winId%_y, orig_%winId%_width, orig_%winId%_height ; store the old bounds
		WinSet, Style, -0x800000
		WinMove, , , 0, -4, A_ScreenWidth, A_ScreenHeight - 30 ; 1 pixel less, to be able to use the auto-hide taskbar
		isSuperMaximized_%winId% = 1
	}
}


