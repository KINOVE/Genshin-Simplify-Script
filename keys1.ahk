; 脚本只在以下条件满足时执行
#Include core\core.ahk
#Include module\module.ahk
#HotIf Genshin.is_game_active()
; --------------------------------Settings 设置--------------------------------

; 开启每秒一次的界面检测和按键提示
OpenSmartGuiTips := setting.getIni("global","OpenSmartGuiTips")


; --------------------------------功能--------------------------------

; 每秒刷新：显示当前界面快捷键
if(OpenSmartGuiTips){
    ; MsgBox("!")
    SetTimer () => WhichGUI.smartGuiTips(), 1000, -100
}

; setting.initSetting()

; 开关部分脚本功能
`::Status.Toggle()

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

; 快速传送
^t::{
    mapTeleport.fastTeleport()

}

;自动派遣 & 日常任务奖励
; !p:: Dispatch.dispatch()
!p:: Dispatch.FindYellowTarget()

;纪行奖励领取
^F4:: {
    BattlePass.bp_award()
}

; 使用四星狗粮
!q:: Artifact.enhance_once()
; 使用五星狗粮
!w:: Artifact.enhance_five()
; 取消锁定
!e:: Artifact.cancel_lock()

; 跳过圣遗物副本动画
^f:: {
    Sleep(500)
    Domain.skip_award()
}
