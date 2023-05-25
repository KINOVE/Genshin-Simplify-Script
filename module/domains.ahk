#Include ../core/point.ahk
#Include ../core/genshin.ahk
#Include ../core/tool.ahk

class Domain {
    static p_choose_condensed_resin := Point(Pos(955, 744), Pos(602, 744))
    static p_skip_btn := Point(Pos(2418, 50), Pos(1788, 50))
    ; static p3 := Point(Pos(659, 507), Pos(573, 507))
    static p_reward_area := [
        Point(Pos(659, 507), Pos(573, 507)),
        Point(Pos(1559,590))
    ]

    static p_exit_btn_area := [
        Point(Pos(900, 984)),
        Point(Pos(931, 1012))
    ]


    static refresh_pos(){
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        this.p_choose_condensed_resin.refresh_pos()
        this.p_skip_btn.refresh_pos()
    }

    ; 圣遗物副本结束奖励领取
    static skip_award(){
        SendInput('f')
        Sleep(300)
        Tool.MClick( this.p_choose_condensed_resin, 0)
        Sleep(600)
        loop 3{
            Tool.MClick( this.p_skip_btn, 0)
        }
        Sleep(250)
        Tool.MClick( this.p_skip_btn, 0)
        Sleep(4000)
        targetx:= 0, targety:= 0
        if(Tool.pixelSearchPlus(this.p_reward_area[1], this.p_reward_area[2], '0xb37c36', &targetx, &targety)){
            MouseMove(targetx, targety)
        }
        else if(Tool.pixelSearchPlus(this.p_reward_area[1], this.p_reward_area[2], '0x8f79c4', &targetx, &targety)){
            MouseMove(targetx, targety)
        }
        
        ih := InputHook("V T20")
        ih.KeyOpt("{N}{Esc}","E")
        ih.Start()
        ih.Wait()
        switch ih.EndKey {
            case 'n':
                this.next_round()
            case 'Escape':
                this.exit()
            default:
                return
        }
    }

    ; 圣遗物副本结束后，直接退出
    static exit(){
        Sleep(500)
        targetx := 0, targety := 0
        if (
            Tool.pixelSearchPlus(this.p_exit_btn_area[1],this.p_exit_btn_area[2], '0x2d2e2b') &&
            Tool.pixelSearchPlus(this.p_exit_btn_area[1],this.p_exit_btn_area[2], '0x349ee1', &targetx, &targety)
        )
        {
            MouseClick(, targetx, targety)
        }
    }

    ; 圣遗物副本结束后，进入下一轮
    static next_round(){
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        static p1 := Point(Pos(1324, 978), Pos(1006, 978))
        static p2 := Point(Pos(1369, 1021), Pos(1044, 1021))
        p1.refresh_pos()
        p2.refresh_pos()
        static targetColorPositionX := 0
        static targetColorPositionY := 0
        if( PixelSearch(&targetColorPositionX,&targetColorPositionY,p1.x,p1.y,p2.x,p2.y,'0x323131', 20) && 
            PixelSearch(&targetColorPositionX,&targetColorPositionY,p1.x,p1.y,p2.x,p2.y,'0xffcb32', 20)){
            MouseClick(,targetColorPositionX, targetColorPositionY,,0)
            Sleep(3000)
            Click(2)
        }
    }
}