; 脚本只在以下条件满足时执行
#Include core\core.ahk
#Include module\module.ahk
#HotIf Genshin.is_game_active() && (Status.IsActive() || Status.IsFlyOrDive())
; 快速拾取&对话
f::{
    SendInput('f')
    pick(){
        if GetKeyState('f','P'){
            Sleep(30)
            SendInput('f')
        } else {
            SetTimer(pick, 0)
        }
    }
    SetTimer(pick, 30)
}
f Up:: SendInput('{f Up}')



#HotIf Genshin.is_game_active() && Status.IsActive()

; 连跳
Space:: {
    SendInput('{Space}')
}