#Include core\core.ahk
#Include module\module.ahk
#HotIf Genshin.is_game_active() || WhichGUI.isScreen2()
; x::MsgBox(Genshin.is_game_active() && WhichGUI.isScreen2())

; #HotIf (Genshin.is_game_active() && WhichGUI.isScreen2())
; 地图界面下生效

; 缩小
^X::{
    MouseGetPos(&x,&y)
    Tool.MClick(Point(Pos(0,0),Pos(46,651)))
    MouseMove(x,y,0)
}

; 放大
^C::{
    MouseGetPos(&x,&y)
    Tool.MClick(Point(Pos(0,0),Pos(47,421)))
    MouseMove(x,y,0)
}