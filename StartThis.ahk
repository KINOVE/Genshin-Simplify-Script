; 推荐安装官网的统一新环境，可以兼容多版本的AHK，按以下格式声明版本即可（缺少的它会自动下载）
#Requires AutoHotkey v2.0
#SingleInstance

/* Core */
#Include core/genshin.ahk
#Include core/whichGUI.ahk
#Include core/tool.ahk
#Include core/point.ahk
#Include core/ini.ahk
#Include core/ActiveLock.ahk
#Include core\PointExtractor.ahk

/* Module */
#Include module/artifact.ahk
#Include module/dispatch.ahk
#Include module/domains.ahk
#Include module/team.ahk
#Include module/battlePass.ahk
#Include module/map.ahk
#Include module/checkOrQuit.ahk

/* Global */
; 当前所处在哪个游戏界面
global now_GUI := -1
; 是否正在执行其他功能
global executing_function := false
; 调试用功能，快速Reload脚本
^!r:: Reload

!`::PointExtractor.getPoint()
!^`::PointExtractor.searchColor()

!^1::{
    MsgBox(WhichGUI.whichGUI())
}


; 队伍切换
global teamChangeBtn := setting.getIni("global","teamChangeBtn")
; 行走和奔跑的状态切换（也是花灵降低高度的按钮）
global walkRunSwitch := setting.getIni("global","walkRunSwitch")

/* ShortCutKeys */
#Include ShortcutKeys1.ahk
#Include ShortcutKeys2.ahk
#Include ShortcutKeys3.ahk
#Include ShortcutKeys4.ahk
#Include ShortcutKeys5.ahk


