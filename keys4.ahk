#Include core\core.ahk
#Include module\module.ahk
; 处于队伍切换界面时
#HotIf Genshin.is_game_active() && (WhichGUI.isScreen6() == true)
^a::{
    Tool.MClick(Point(Pos(137,538),Pos(79,537)))
}
^d::{
    Tool.MClick(Point(Pos(2420,538),Pos(1848,537)))
}
^Space::{
    Tool.MClick(Point(Pos(2128,1019), Pos(1557, 1019)))
}