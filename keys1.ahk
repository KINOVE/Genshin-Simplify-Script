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
; ^1:: WhichGUI.changeTeamOrTeleport(1)
; ^2:: WhichGUI.changeTeamOrTeleport(2)
; ^3:: WhichGUI.changeTeamOrTeleport(3)
; ^4:: WhichGUI.changeTeamOrTeleport(4)
; ^5:: WhichGUI.changeTeamOrTeleport(5)
; ^6:: WhichGUI.changeTeamOrTeleport(6)
; ^7:: WhichGUI.changeTeamOrTeleport(7)
; ^8:: Team.changeTeam(8)
; ^9:: Team.changeTeam(9)
; ^0:: Team.changeTeam(0)

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

!1::{
    ToolTip(WhichGUI.whichGUI(),,,10)
    SetTimer () => ToolTip(,,,10), 1000
}

; 一键购买当前商品（杂货店可用）
^b::AutoBuy.autoBuy()

^1::{
    MouseGetPos(&x,&y)
    MsgBox("x" . x . "y" . y)
}

; 那维莱特转圈
XButton1::{
    MRound(){
        if GetKeyState('XButton1','P'){
            ; 按下左键
            SendInput('{LButton Down}')
            ; 转圈
            DllCall('mouse_event','uint',1,'int',1000,'int',0,'uint',0,'int',0)
        } else {
            ; 抬起左键  
            SendInput('{LButton Up}')
            SetTimer(MRound,0)
        }
    }
    SetTimer(MRound,20)
}