class Genshin {
    static game_name_cn:='YuanShen.exe'             ;官服程序名
    static game_name_global:='GenshinImpact.exe'    ;国际服程序名
    static game_size := {
        width : 0,
        height : 0
    }

    static get_game_pos() {
        if ProcessExist(this.game_name_cn) {
            WinGetClientPos(, , &width, &height, 'ahk_exe ' this.game_name_cn)
        } else if ProcessExist(this.game_name_global) {
            WinGetClientPos(, , &width, &height, 'ahk_exe ' this.game_name_global)
        } else {
            this.game_size.width := 0
            this.game_size.height := 0
            return [width, height]
        }
        this.game_size.width := width
        this.game_size.height := height
        return [width, height]
    }

    static is_game_exist() {
        return ProcessExist(this.game_name_cn) or ProcessExist(this.game_name_global)
    }

    static is_game_active(){
        return WinActive('ahk_exe ' this.game_name_cn) or WinActive('ahk_exe ' this.game_name_global)
    }

    static close_game(){
        if WinExist('ahk_exe ' this.game_name_cn)
            WinClose
        else if WinExist('ahk_exe ' this.game_name_global)
            WinClose
        ExitApp
    }
}