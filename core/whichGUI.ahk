#Include point.ahk
#Include ../StartThis.ahk
; 用于定位当前处于哪种用户界面中
;   1:游戏主界面
;   2:地图界面
;   3:副本界面
;   4:派遣界面
;   -1:未能识别
class WhichGUI {
    static mainPaimon := Point(Pos(121, 72))
    static mainMission := Point(Pos(139, 204))
    static mainPaimon2 := Point(Pos(117,63))
    static mapChioceAreaBtn := Point(Pos(2411, 1018))
    static dispathIcon := Point(Pos(139, 57))
    static mapZoomA := Point(Pos(103, 440))
    static mapZoomB := Point(Pos(131, 639))
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
        ,
        ""
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

    ; 根据取到的当前GUI的ID进行Tooltips的显示
    static showTips(nowGuiId){
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        ; 改成数组中对应的空部分
        if(nowGuiId == -1)
            nowGuiId := 5
        ; 这种情况为游戏界面未激活，now_GUI置于-2
        global now_GUI
        if(now_GUI != nowGuiId){
            this.emptyToolTip(11)
            now_GUI := nowGuiId
            ToolTip(this.GuiTips[nowGuiId], width/20, height/3, 11)
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
        if executing_function{
            this.emptyToolTip()
            return
        }
        this.showTips(this.WhichGUI())
    }

    ; 判断当前所处界面并返回
    static whichGUI(){
        ; 判别依据
        main_1 := PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) == '0xFFFFFF'
        main_2 := PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xFFFFFF'
        main_3 := PixelGetColor(this.mainPaimon2.x, this.mainPaimon2.y) == '0xFAEEE0'
        ; 测试只通过zoom是否能够判别地图界面
        ; map_1 := Tool.pixelExist(this.mapChioceAreaBtn, '0xe2dccf')
        map_2 := Tool.pixelSearchPlus(this.mapZoomA, this.mapZoomB, '0xede5da', , , 0)
        ; map_3 := Tool.pixelExist()
        battle_1 := PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) != '0xFFFFFF' 
        battle_2 := PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xFFFFFF'
        dispatch_1 := PixelGetColor(this.dispathIcon.x, this.dispathIcon.y) == '0xECE5D8'
        ;   1:游戏主界面
        if ( main_1 && main_2 && main_3){
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