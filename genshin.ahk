class Genshin {
    static game_name_cn:='YuanShen.exe'             ;官服程序名
    static game_name_global:='GenshinImpact.exe'    ;国际服程序名

    static get_game_pos() {
        if ProcessExist(this.game_name_cn) {
            WinGetClientPos(, , &width, &height, 'ahk_exe ' this.game_name_cn)
        } else if ProcessExist(this.game_name_global) {
            WinGetClientPos(, , &width, &height, 'ahk_exe ' this.game_name_global)
        } else {
            width := 0
            height := 0
        }
        return [width, height]
    }

    static is_game_exist() {
        return ProcessExist(this.game_name_cn) or ProcessExist(this.game_name_global)
    }

    static is_game_active(){
        return WinActive('ahk_exe ' this.game_name_cn) or WinActive('ahk_exe ' this.game_name_global)
    }

    static close_game(){
        WinClose('ahk_exe ' this.game_name_cn)
        WinClose('ahk_exe ' this.game_name_global)
        ExitApp
    }
}