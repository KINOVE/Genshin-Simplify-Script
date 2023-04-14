#Requires AutoHotkey v2.0
#SingleInstance
;脚本只在以下条件满足时执行
#HotIf Genshin.is_game_active()

; --------------------------------Core
#Include core/genshin.ahk
#Include core/whichGUI.ahk
#Include core/tool.ahk
#Include core/point.ahk

;---------------------------------Module
#Include module/artifact.ahk
#Include module/dispatch.ahk
#Include module/skip.ahk
#Include module/team.ahk
#Include module/battlePass.ahk
#Include module/map.ahk

; --------------------------------Global
global isActive := false

;---------------------------------Trigger
; —————————全局—————————

; 开关部分脚本功能
`::{
    global isActive := !isActive
    if isActive{
        ToolTip('开启', 400, 400, 20)
    }
    else{
        ToolTip('', , , 20)
    }
    ; SetTimer () => ToolTip('',,,20), -2000
}

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

; 连跳
Space:: {
    if (isActive){
        SendInput('{Space}')
    }
    else{
        SendInput('{Space Down}')
        ; SendInput('{Space Up}')
    }
}
Space Up:: SendInput('{Space Up}')


; 使用四星狗粮
!q:: Artifact.enhance_once()
; 使用五星狗粮
!w:: Artifact.enhance_five()
; 取消锁定
!e:: Artifact.cancel_lock()

; 跳过圣遗物副本动画
^s:: Skip.skip_award()

; 显示当前界面快捷键
Ctrl:: {
    if(isActive){
        WhichGUI.smartGuiTips()
    }
    else{
        ; 屏蔽原本Ctrl键的步态切换功能（用else输入Ctrl Down）
        SendInput('{Ctrl Down}')
    }
}
Ctrl Up:: SendInput('{Ctrl Up}')

;自动派遣
!p:: Dispatch.dispatch()


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

; Test:快速传送
^t::mapTeleport.fastTeleport()

; 鼠标快速连点
^!LButton::{
    Click
    clickPlus(){
        if GetKeyState('LButton','P'){
            Sleep(Random(100,150))
            Click
        } else {
            SetTimer(clickPlus, 0)
        }
    }
    SetTimer(clickPlus, 50)
}

; 快速退出游戏
^Esc:: Genshin.close_game()

;调试用功能，快速Reload脚本
^!r:: Reload