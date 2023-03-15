#Include point.ahk
#Include genshin.ahk

Class mapTeleport {
    static chioceAreaBtn := Point(2411, 1018)
    static AreaBtn := [Point(2115,149), Point(2115,268)]
    static CenterPoint := Point(1272,535)
    static targetBtnRange := [Point(1730,160), Point(1794,938)]

    static teleportToArea(AreaId) {
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
            MouseClick(, this.chioceAreaBtn.x, this.chioceAreaBtn.y, ,0)
        }
    }
}