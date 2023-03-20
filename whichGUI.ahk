#Include point.ahk
#Include main.ahk
; 用于定位当前处于哪种用户界面中
;   1:游戏主界面
;   2:地图界面
;   3:副本界面
;   -1:未能识别
class WhichGUI {
    static mainPaimon := Point(121, 72)
    static mainMission := Point(139, 204)
    static mapChioceAreaBtn := Point(2411, 1018)

    ; 判断当前所处界面并返回
    static whichGUI(){
        static temp := 0
        if (PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) == '0xFFFFFF'
            && PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xFFFFFF'){
            ; ToolTip("1")
            return 1
        }
        else if (PixelSearch(&temp, &temp, this.mapChioceAreaBtn.x - 5, this.mapChioceAreaBtn.y - 5, this.mapChioceAreaBtn.x + 5, this.mapChioceAreaBtn.y + 5, '0xe2dccf', 20)){
            ; ToolTip("2")
            return 2
        }
            
        else if (PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) != '0xFFFFFF' 
                && PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xFFFFFF')
            return 3
        else{
            ; ToolTip()
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
}