; 脚本只在以下条件满足时执行
#Include StartThis.ahk
#HotIf Genshin.is_game_active() && Status.IsActive()
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

; 连跳
Space:: {
    SendInput('{Space}')
}