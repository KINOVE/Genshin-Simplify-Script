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

    /**
     * getIni -> 获取对应设置内容
     * @param section 所属的`[section]`字段
     * @param key `key=...`
     * @returns {`any`} `key=value` <- `value`值
     */
    static getIni(section,key){
        return IniRead(this.iniPath,section,key)
    }
}