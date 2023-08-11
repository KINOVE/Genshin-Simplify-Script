; IniWrite("test", this.iniPath, "maybe", "keys")
; IniWrite("test", this.iniPath, "maybe", "keys2")
; IniWrite("test", this.iniPath, "maybe", "keys3")
; IniWrite("test", this.iniPath, "maybe", "keys4")
; [maybe]
; keys=test
; keys2=test
; keys3=test
; keys4=test

class setting {
    static iniPath := "Settings.ini"
    static initSetting(){
        this.setIni("global","OpenSmartGuiTips",true)
        this.setIni("global","teamChangeBtn","g")
        this.setIni("global","walkRunSwitch","h")
    }

    ; 简写 -> 为什么原生参数顺序这么奇怪？
    static setIni(section,key,value){
        IniWrite(value,this.iniPath,section,key)
    }

    static getIni(section,key){
        if IniRead(this.iniPath,section,key) == true {
            MsgBox("1")
        }
        return IniRead(this.iniPath,section,key)
    }
}