#Include point.ahk

; 用于定位当前处于哪种用户界面中
;   1:游戏主界面
;   2:地图界面
;   3:副本界面
;   4:派遣界面
;   -1:未能识别
class WhichGUI {
    static mapChioceAreaBtn := Point(Pos(2411, 1018), Pos(1841, 1018))
    
    
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
        "artifact_strengthen"
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
            nowGuiId := 6
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
        this.showTips(this.WhichGUI())
    }

    /*
    判断当前所处界面并返回
    1 ->  游戏主界面
    2 ->  地图界面
    3 ->  副本界面
    4 ->  派遣界面
    5 ->  圣遗物强化界面
    6 ->  队伍配置界面
    -1->  未能识别*/
    static whichGUI(){
        ;   1:游戏主界面
        if ( this.isScreen1() )
            return 1
        ;   2:地图界面
        else if (this.isScreen2())
            return 2
        ;   3:副本界面
        else if ( this.isScreen3() )
            return 3
        ;   4:派遣界面
        else if ( this.isScreen4() )
            return 4
        ;   5:圣遗物强化界面
        else if ( this.isScreen5() )
            return 5
        ;   6:队伍配置界面
        else if this.isScreen6() {
            return 6
        }
        ;   -1:未能识别
        else{
            return -1
        }
    }

    ; 是否为大世界游戏界面（主界面）
    static isScreen1(){
        static mainPaimon := Point(Pos(121, 72),Pos(55, 60))
        static mainMission := Point(Pos(139, 204),Pos(46,72))
        static mainPaimon2 := Point(Pos(117,63),Pos(67,32))
        ; 判别依据
        main_1 := PixelGetColor(mainPaimon.x, mainPaimon.y) == Color('#FFFFFF').c
        main_2 := PixelGetColor(mainMission.x, mainMission.y) == Color('#FFFFFF').c
        main_3 := Tool.pixelExist(mainPaimon2, Color('#e9c48f').c)
        ; temp := PixelGetColor(mainPaimon2.x, mainPaimon2.y) == Color('#e9c48f').c
        return main_1 && main_2 && main_3
    }

    ; 是否为地图界面
    static isScreen2(){
        static mapZoomA := Point(Pos(103, 440),Pos(37,442))
        static mapZoomB := Point(Pos(131, 639),Pos(59,639))
        ; 测试只通过zoom是否能够判别地图界面
        ; map_1 := Tool.pixelExist(this.mapChioceAreaBtn, '0xe2dccf')
        map_2 := Tool.pixelSearchPlus(mapZoomA, mapZoomB, '0xede5da', , , 0)
        ; map_3 := Tool.pixelExist()
        return map_2
    }

    ; 是否为副本界面
    static isScreen3(){
        static mainPaimon := Point(Pos(121, 72),Pos(55, 60))
        static mainMission := Point(Pos(139, 204),Pos(46,60))
        battle_1 := PixelGetColor(mainPaimon.x, mainPaimon.y) != '0xFFFFFF' 
        battle_2 := PixelGetColor(mainMission.x, mainMission.y) == '0xFFFFFF'
        return battle_1 && battle_2
    }

    static isScreen4(){
        ; TODO -> fix
        static dispathIcon := Point(Pos(139, 57), Pos(75,24))
        dispatch_1 := PixelGetColor(dispathIcon.x, dispathIcon.y) == Color('#ECE5D8').c
        return dispatch_1
    }

    static isScreen5(){
        ; TODO -> fix
        static artifact_strengthen_icon := Point(Pos(143,39), Pos(0,0))
        artifact_strengthen := PixelGetColor(artifact_strengthen_icon.x, artifact_strengthen_icon.y) == '0xD3BC8E'
        return artifact_strengthen
    }

    ; 队伍配置界面
    static isScreen6(){
        static pointRange := [
            Point(Pos(0,0),Pos(56,998)),
            Point(Pos(0,0),Pos(98,1048))
        ]
        params := "*100"
        filePath := "files\team_select.png"
        Tool.imgSearch(&x,&y,pointRange,params,filePath,Color("#3b4255"))
        if (x != "" && y != "") {
            return true
        }
        return false
    }

    ; 通过识别当前界面来决定：切换队伍还是传送
    static changeTeamOrTeleport(num) {
        ; 如果是游戏主界面：
        if (this.whichGUI() == 1){
            Team.changeTeam(num)
        }
        ; 如果是地图界面：
        else if (this.whichGUI() == 2){
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