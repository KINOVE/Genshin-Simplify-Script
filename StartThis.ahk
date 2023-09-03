; 推荐安装官网的统一新环境，可以兼容多版本的AHK，按以下格式声明版本即可（缺少的它会自动下载）
#Requires AutoHotkey v2.0.7
#SingleInstance

/* Core */
#Include core/core.ahk

/* Module */
#Include module/module.ahk

/* Global */
; 当前所处在哪个游戏界面
global now_GUI := -1
; 调试用功能，快速Reload脚本
^!r:: Reload

!`::PointExtractor.getPoint()
!^`::PointExtractor.searchColor()

!^1::{
    MsgBox(WhichGUI.whichGUI())
}


; 队伍切换
; global teamChangeBtn := setting.getIni("global","teamChangeBtn")
; 行走和奔跑的状态切换（也是花灵降低高度的按钮）
; global walkRunSwitch := setting.getIni("global","walkRunSwitch")

/* ShortCutKeys */
#Include keys1.ahk
#Include keys2.ahk
#Include keys3.ahk
#Include keys4.ahk
#Include keys5.ahk
#Include keys6.ahk

