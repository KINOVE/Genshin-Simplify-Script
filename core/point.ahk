class Point {
    __New(x := '', y := '') {
        this.x := x
        this.y := y
        this.x0 := x
        this.y0 := y
    }

    refresh_pos(game_width, game_height, width_169?) {
        ; MsgBox('game_width/game_height:' . game_width/game_height . '|16/9' . 16/9)
        if(this.x0 == '' || this.y0 == ''){
            MsgBox('获取分辨率失败，请检查脚本 => 修改后请按Ctrl+Alt+R重置脚本状态')
            Pause
        }
        switch game_width/game_height {
            case 21/9:
                ; MsgBox('21/9')
                this.x := this.x0 * game_width / 2560
                this.y := this.y0 * game_height / 1080
            case 16/9:
                ; MsgBox('16:9')
                if(IsSet(width_169)){
                    this.x0 := width_169
                }
                this.x := this.x0 * game_width / 1920
                this.y := this.y0 * game_height / 1080
            default:
                MsgBox("当前暂不支持的分辨率：" . game_width . '/' . game_height)
        }
    }
}