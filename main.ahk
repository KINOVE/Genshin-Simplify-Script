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
#Include map.ahk
#Include whichGUI.ahk
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
^F4:: BattlePass.bp_award()

; Ctrl + [1 ~ 0] 切换队伍
; Ctrl + [1 ~ 7] 传送到各地区（注意：此功能会根据游戏进度不同导致部分地区未解锁，请按实际情况选择）
; 蒙德
; 璃月
; 稻妻
; 须弥
; 渊下宫
; 层岩
; 尘歌壶
^1:: WhichGUI.changeTeamOrTeleport(1)
^2:: WhichGUI.changeTeamOrTeleport(2)
^3:: WhichGUI.changeTeamOrTeleport(3)
^4:: WhichGUI.changeTeamOrTeleport(4)
^5:: WhichGUI.changeTeamOrTeleport(5)
^6:: WhichGUI.changeTeamOrTeleport(6)
^7:: WhichGUI.changeTeamOrTeleport(7)
^8:: Team.changeTeam(8)
^9:: Team.changeTeam(9)
^0:: Team.changeTeam(0)

; 测试功能：传送到日常差事结算地点璃月👍 已修改至上方
; ^q:: mapTeleport.teleportToArea(2)

; 快速退出游戏
^Esc:: Genshin.close_game()


;调试用功能，快速Reload脚本
^!r:: Reload