#Include ini.ahk
Class Keys{

    ; 队伍切换
    static teamChangeBtn(){
        return setting.getIni("global","teamChangeBtn")
    }

    ; 行走和奔跑的状态切换（也是花灵降低高度的按钮）
    static walkRunSwitch(){
        return setting.getIni("global","walkRunSwitch")
    }
}