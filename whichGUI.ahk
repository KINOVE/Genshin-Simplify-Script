#Include point.ahk
; 用于定位当前处于哪种用户界面中
;   1:游戏主界面
;   2:地图界面
;   3:副本界面
;   -1:未能识别
class WhichGUI {
    static mainPaimon := Point(128, 52)
    static mainMission := Point(139, 240)
    static mapChioceAreaBtn := Point(2411, 1018)
    static whichGUI(){
        static temp := 0
        if (PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) == '0xffffff' 
            && PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xffffff')
            return 1
        else if (PixelSearch(&temp, &temp, this.mapChioceAreaBtn.x - 5, this.mapChioceAreaBtn.y - 5, this.mapChioceAreaBtn.x + 5, this.mapChioceAreaBtn.y + 5, '0xe2dccf', 20))
            return 2
        else if (PixelGetColor(this.mainPaimon.x, this.mainPaimon.y) != '0xffffff' 
                && PixelGetColor(this.mainMission.x, this.mainMission.y) == '0xffffff')
            return 3
        else
            return -1
    }
}