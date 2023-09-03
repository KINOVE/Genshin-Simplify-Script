; 脚本只在以下条件满足时执行
; #Include StartThis.ahk
#Include core\core.ahk
#Include module\module.ahk
#HotIf Genshin.is_game_active() && (Status.IsNotActive() || Status.IsFlyOrDive())

; 实现走/跑切换按键的屏蔽开关逻辑
Ctrl:: {
    ; walkRunSwitch := setting.getIni("global","walkRunSwitch")]
    SendInput('{' . Keys.walkRunSwitch() . ' Down}')
}

Ctrl Up::{
    ; teamChangeBtn := setting.getIni("global","teamChangeBtn")
    SendInput('{' . Keys.walkRunSwitch() . ' Up}')
}