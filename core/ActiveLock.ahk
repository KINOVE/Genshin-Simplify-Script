; 用于控制脚本功能开关
Class Status{

    ; 0 -> normal   开启连跳和Ctrl功能键
    ; 1 -> fly      花灵飞行模式，连跳和Ctrl功能键关闭

    static Active := true
    
    ; 是否激活
    static IsActive(){
        return this.Active
    }

    ; 是否关闭
    static IsNotActive(){
        return !this.Active
    }

    ; 切换状态
    static Toggle(){
        this.Active := !this.Active
        if Status.IsNotActive() {
            ToolTip('关闭', 400, 400, 20)
        }
        else {
            ToolTip('', , , 20)
        }
    }

    ; 激活
    static SetTrue(){
        this.Active := true
    }

    ; 关闭
    static SetFalse(){
        this.Active := false
    }
}