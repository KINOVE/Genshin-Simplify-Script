#Include core\core.ahk
#Include module\module.ahk
; 处于队伍切换界面时
#HotIf Genshin.is_game_active() && (WhichGUI.whichGUI() == 6)
^a::{
    Tool.MClick(Point(Pos(0,0),Pos(79,537)))
}
^d::{
    Tool.MClick(Point(Pos(0,0),Pos(1848,537)))
}
^Space::{
    Tool.MClick(Point(Pos(0,0), Pos(1557, 1019)))
}