#Include point.ahk
#Include genshin.ahk
#Include whichGUI.ahk

Class mapTeleport {
    static chioceAreaBtn := Point(2411, 1018)
    static AreaBtn := [Point(2115,149), Point(2115,268), Point(2115,387), Point(2115,506), Point(2115,625), Point(2115,744), Point(2115,863)]
    static CenterPoint := Point(1272,535)
    static targetBtnRange := [Point(1730,160), Point(1794,938)]
    static teleportBtn := Point(2047, 1013)

    
    ; 在目标点位附近搜素颜色相近的目标，可选择是否提供目标输出
    static pixelExist(target, colorId, &outputX?, &outputY?, range := 10, colorDeviation := 10){
        ; 假如提供了输出（被找到的点位坐标）
        if IsSet(outputX){
            return PixelSearch(&outputX, &outputY, target.x - range/2, target.y - range/2, target.x + range/2, target.y + range/2, colorId, colorDeviation)
        }
        else{
            local temp
            return PixelSearch(&temp, &temp, target.x - range/2, target.y - range/2, target.x + range/2, target.y + range/2, colorId, colorDeviation)
        }
    }

    static teleportToArea(AreaId) {
        if (WhichGUI.whichGUI() != 2)
            return
        MouseClick(, this.chioceAreaBtn.x, this.chioceAreaBtn.y, ,0)
        if (AreaId = 1)
            MouseClick(, this.AreaBtn[2].x, this.AreaBtn[2].y, ,0)
        else{
            MouseClick(, this.AreaBtn[1].x, this.AreaBtn[1].y, ,0)
        }
        Sleep(500)
        MouseClick(, this.chioceAreaBtn.x, this.chioceAreaBtn.y, ,0)
        MouseClick(, this.AreaBtn[AreaId].x, this.AreaBtn[AreaId].y, ,0)
        MouseClick(, this.CenterPoint.x, this.CenterPoint.y, ,0)
        Sleep(400)
        static targetBtnX := 0
        static targetBtnY := 0
        if(PixelSearch(&targetBtnX, &targetBtnY
            , this.targetBtnRange[1].x, this.targetBtnRange[1].y
            , this.targetBtnRange[2].x, this.targetBtnRange[2].y, '0x2d91d9', 10)) {
            MouseClick(, targetBtnX, targetBtnY, ,0)
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
        else if (this.pixelExist(this.teleportBtn, '0xffcd33')){
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
    }
}