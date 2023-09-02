; 用于控制脚本功能开关
#Include genshin.ahk
Class Status{

    ; 0 -> normal   开启连跳和Ctrl功能键
    ; 1 -> 关闭所有功能
    ; 2 -> fly/dive      花灵飞行模式/潜水模式，连跳和Ctrl功能键关闭

    static Active := true
    
    ; 是否激活
    static IsActive(){
        if this.Active == 0 {
            return true
        }
        return false
    }

    ; 是否关闭
    static IsNotActive(){
        if this.Active == 1 {
            return true
        }
        return false
    }

    ; 是否为潜水
    static IsFlyOrDive(){
        if this.Active == 2 {
            return true
        }
        return false
    }

    ; 切换状态
    static Toggle(){
        this.Active := Mod(this.Active + 1, 3)
        width := 0
        height := Genshin.game_size.height/2
        if Status.IsNotActive() {
            ToolTip('关闭', width, height, 20)
        }
        else if Status.IsFlyOrDive() {
            ToolTip('Fly/Dive', width, height, 20)
        }
        else {
            ToolTip('', , , 20)
        }
    }

    ; 激活为正常模式
    static SetTrue(){
        this.Active := 0
    }

    ; Fly/Diving模式
    static SetFlyOrDive(){
        this.Active := 2
    }

    ; 关闭
    static SetFalse(){
        this.Active := 1
    }
}