; 推荐安装官网的统一新环境，可以兼容多版本的AHK，按以下格式声明版本即可（缺少的它会自动下载）
#Requires AutoHotkey v2.0
#SingleInstance
; 脚本只在以下条件满足时执行
#HotIf Genshin.is_game_active()

/* Core */
#Include core/genshin.ahk
#Include core/whichGUI.ahk
#Include core/tool.ahk
#Include core/point.ahk

/* Module */
#Include module/artifact.ahk
#Include module/dispatch.ahk
#Include module/domains.ahk
#Include module/team.ahk
#Include module/battlePass.ahk
#Include module/map.ahk

/* Global */
global isActive := true
global now_GUI := -1
global executing_function := false

; ⚠⚠⚠ 不明白在干什么的话，就别改上面的内容 ⚠⚠⚠


; myGui.Show()

; --------------------------按键（填游戏里设置的按键）-------------------------

; 队伍切换
global teamChangeBtn := 'g' 

; 行走和奔跑的状态切换（也是花灵降低高度的按钮）
global walkRunSwitch := 'h' 

; --------------------------------Settings 设置--------------------------------

; 开启每秒一次的界面检测和按键提示
OpenSmartGuiTips := true


; --------------------------------功能--------------------------------

; 每秒刷新：显示当前界面快捷键
if(OpenSmartGuiTips){
    SetTimer () => WhichGUI.smartGuiTips(), 1000, -100
}

; 开关部分脚本功能
`::{
    global isActive := !isActive
    if !isActive{
        ToolTip('关闭', 400, 400, 20)
    }
    else{
        ToolTip('', , , 20)
    }
}

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
    if (isActive){
        SendInput('{Space}')
    }
    else{
        SendInput('{Space Down}')
    }
}
Space Up:: SendInput('{Space Up}')

; 实现走/跑切换按键的屏蔽开关逻辑
Ctrl:: {
    if(isActive){
        ; WhichGUI.smartGuiTips()
        SendInput('{Ctrl Down}')
    }
    else{
        SendInput('{' . walkRunSwitch . ' Down}')
    }
}
Ctrl Up::{ 
    if(isActive){
        SendInput('{Ctrl Up}')
    }
    else{
        SendInput('{Ctrl Up}')
        SendInput('{' . walkRunSwitch . ' Up}')
    }
}

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
^t::mapTeleport.fastTeleport()

;自动派遣 & 日常任务奖励
; !p:: Dispatch.dispatch()
!p:: Dispatch.FindYellowTarget()

;纪行奖励领取
^F4:: BattlePass.bp_award()


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

#HotIf
; !`::{
;     if(!WinExist("ahk_id " myGui.Hwnd)){
;         myGui.Show()
;     }
;     else{
;         myGui.Hide()
;     }
; }

; 调试用功能，快速Reload脚本
^!r:: Reload