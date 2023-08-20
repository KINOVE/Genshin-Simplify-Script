; 脚本只在以下条件满足时执行
#Include StartThis.ahk
#HotIf Genshin.is_game_active() && Status.IsNotActive()
; 实现走/跑切换按键的屏蔽开关逻辑
Ctrl:: {
    SendInput('{' . walkRunSwitch . ' Down}')
    ; SendInput('{h}')
}

Ctrl Up::{
    SendInput('{' . walkRunSwitch . ' Up}')
}