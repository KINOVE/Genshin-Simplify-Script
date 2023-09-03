#Include core\core.ahk
#Include module\module.ahk
#HotIf Genshin.is_game_active() && WhichGUI.isScreen2()
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

; 删除标点
^D::{
    p_delete_btn := Point(,Pos(1476,1012))
    c_delete_btn := Color("#FE5C5C").c
    if Tool.pixelExist(p_delete_btn, c_delete_btn) {
        MouseGetPos(&x,&y)
        Tool.MClick(p_delete_btn)
        MouseMove(x,y,0)
    }
}