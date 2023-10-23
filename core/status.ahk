; 用于控制脚本功能开关
#Include genshin.ahk
Class Status{

    ; 0 -> normal   开启连跳和Ctrl功能键
    ; 1 -> 关闭所有功能
    ; 2 -> fly/dive      花灵飞行模式/潜水模式，连跳和Ctrl功能键关闭

    static Active := 0
    
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

    static duration := 50

    ; 切换状态
    static Toggle(){
        this.Active := Mod(this.Active + 1, 3)
        width := 0
        height := Genshin.game_size.height/2
        if Status.IsNotActive() {
            SoundPlay("files/audio/close.wav")
            ; SoundBeep(1000,this.duration)
            ToolTip('关闭', width, height, 20)
        }
        else if Status.IsFlyOrDive() {
            SoundPlay("files/audio/fly_mode.wav")
            ; SoundBeep(250,this.duration)
            ToolTip('Fly/Dive', width, height, 20)
        }
        else {
            SoundPlay("files/audio/open.wav")
            ; SoundBeep(500,this.duration)
            ToolTip('', , , 20)
        }
    }

    ; 激活为正常模式
    static SetTrue(){
        width := 0
        height := Genshin.game_size.height/2
        this.Active := 0
        SoundPlay("files/audio/open.wav")
        ToolTip('', , , 20)
    }

    ; Fly/Diving模式
    static SetFlyOrDive(){
        width := 0
        height := Genshin.game_size.height/2
        this.Active := 2
        SoundPlay("files/audio/fly_mode.wav")
        ToolTip('Fly/Dive', width, height, 20)
    }

    ; 关闭
    static SetFalse(){
        width := 0
        height := Genshin.game_size.height/2
        this.Active := 1
        SoundPlay("files/audio/close.wav")
        ToolTip('关闭', width, height, 20)
    }
}