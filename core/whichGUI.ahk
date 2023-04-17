#Include point.ahk
#Include ../StartThis.ahk
; 用于定位当前处于哪种用户界面中
;   1:游戏主界面
;   2:地图界面
;   3:副本界面
;   4:派遣界面
;   -1:未能识别
class WhichGUI {
    static mainPaimon := Point(121, 72)
    static mainMission := Point(139, 204)
    static mapChioceAreaBtn := Point(2411, 1018)
    static dispathIcon := Point(139, 57)
    static mapZoomA := Point(103, 440)
    static mapZoomB := Point(131, 639)
    static newline := '`n'
    static GuiTips := [
        "=====游戏主界面=====" this.newline . 
        "Ctrl+[1~10]: 切换队伍" this.newline . 
        "Alt+F4: 纪行"
        , 
        "=====地图界面=====" 
        , 
        "=====副本界面=====" 
        , 
        "=====派遣界面====="
    ]

    ; 清空tooltip
    static emptyToolTip(targetId?){
        if(IsSet(targetId))
            ToolTip('', , ,  targetId)
        else{
            loop 19{
                ToolTip('', , ,  A_Index)
            }
        }
    }

    ; 根据界面显示tooltip
    static smartGuiTips(){
        ; 如果游戏界面未激活
        if !Genshin.is_game_active(){
            ; 清空tips
            this.emptyToolTip()
            now_GUI := -2
            return
        }
        ; 如果正在执行其他功能
        global executing_function
        if executing_function{
            this.emptyToolTip()
            return
        }
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        global now_GUI
        switch this.WhichGUI() {
            case 1:
                if(now_GUI != 1){
                    this.emptyToolTip()
                    now_GUI := 1
                    ToolTip(this.GuiTips[1], width/20, height/3, 11)
                    ; ToolTip('游戏主界面', width/20, height/3, 1)
                    ; ToolTip('Ctrl+[1~10]: 切换队伍', width/20, height/3 + 30, 2)
                    ; ToolTip('Alt+F4: 纪行', width/20, height/3 + 60, 3)
                }
            case 2:
                if(now_GUI != 2){
                    this.emptyToolTip()
                    now_GUI := 2
                    ToolTip(this.GuiTips[2], width/20, height/3, 11)
                    ; ToolTip('地图界面', width/2, height/4, 1)
                }
            case 3:
                if(now_GUI != 3){
                    this.emptyToolTip()
                    now_GUI := 3
                    ToolTip(this.GuiTips[3], width/20, height/3, 11)
                    ; ToolTip('副本界面', width/2, height/4, 1)
                }
            case 4:
                if(now_GUI != 4){
                    this.emptyToolTip()
                    now_GUI := 4
                    ToolTip(this.GuiTips[4], width/20, height/3, 11)
                    ; ToolTip('派遣界面', width/2, height/4, 1)
                }
            case -1:
                if(now_GUI != -1){
                    this.emptyToolTip()
                    now_GUI := -1
                    ; ToolTip('未能识别', width/2, height/4, 1)
                }
        }
        ; SetTimer () => this.emptyToolTip(), -3000
    }

    ; 判断当前所处界面并返回
    static whichGUI(){
        ; 判别依据
        main_1 := PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) == '0xFFFFFF'
        main_2 := PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xFFFFFF'
        ; 测试只通过zoom是否能够判别地图界面
        ; map_1 := Tool.pixelExist(this.mapChioceAreaBtn, '0xe2dccf')
        map_2 := Tool.pixelSearchPlus(this.mapZoomA, this.mapZoomB, '0xede5da', , , 0)
        ; map_3 := Tool.pixelExist()
        battle_1 := PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) != '0xFFFFFF' 
        battle_2 := PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xFFFFFF'
        dispatch_1 := PixelGetColor(this.dispathIcon.x, this.dispathIcon.y) == '0xECE5D8'
        ;   1:游戏主界面
        if ( main_1 && main_2){
            return 1
        }
        ;   2:地图界面
        else if (map_2){
            return 2
        }
        ;   3:副本界面
        else if (battle_1 && battle_2)
            return 3
        ;   4:派遣界面
        else if (dispatch_1)
            return 4
        ;   -1:未能识别
        else{
            return -1
        }
    }

    ; 通过识别当前界面来决定：切换队伍还是传送
    static changeTeamOrTeleport(num) {
        ; 如果是游戏主界面：
        if (this.whichGUI() == 1){
            Team.changeTeam(num)
        }
        ; 如果是地图界面：
        else if (this.whichGUI() == 2){
            ; ToolTip("1")
            mapTeleport.teleportToArea(num)
        }
    }

    ; 通过识别当前界面来决定：每日委托还是探索派遣
    static missionOrdispatch() {
        if (this.whichGUI() == 4){
            Dispatch.dispatch()
        }
    }
}