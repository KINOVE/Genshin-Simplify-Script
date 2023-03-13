#Requires AutoHotkey v2.0
#SingleInstance

#Include genshin.ahk


;脚本只在以下条件满足时执行
#HotIf Genshin.is_game_active()

;引用区
#Include artifact.ahk
#Include point.ahk
#Include dispatch.ahk
#Include skip.ahk
#Include team.ahk
#Include battlePass.ahk
;触发区

;快速拾取&对话
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
Space:: SendInput('{Space}')
;代替空格
v:: SendInput('{Space Down}')
v Up:: SendInput('{Space Up}')


; 使用四星狗粮
!q:: Artifact.enhance_once()
; 使用五星狗粮
!w:: Artifact.enhance_five()
; 取消锁定
!e:: Artifact.cancel_lock()

; 跳过圣遗物副本动画
`:: Skip.skip_award()

;自动派遣
!p:: Dispatch.dispatch()

;自动跳过时间动画(仍然会有滴滴答答的声音)
-:: Skip.skip_time()

;圣遗物副本下一轮
F1:: Skip.next_round()

;纪行奖励领取
F4:: BattlePass.bp_award()

; Ctrl + [1 ~ 0] 切换队伍
^1:: Team.changeTeam(1)
^2:: Team.changeTeam(2)
^3:: Team.changeTeam(3)
^4:: Team.changeTeam(4)
^5:: Team.changeTeam(5)
^6:: Team.changeTeam(6)
^7:: Team.changeTeam(7)
^8:: Team.changeTeam(8)
^9:: Team.changeTeam(9)
^0:: Team.changeTeam(0)