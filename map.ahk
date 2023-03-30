#Include point.ahk
#Include genshin.ahk
#Include whichGUI.ahk

class mapTeleport {
    static chioceAreaBtn := Point(2411, 1018)
    static AreaBtn := [Point(2115,149), Point(2115,268), Point(2115,387), Point(2115,506), Point(2115,625), Point(2115,744), Point(2115,863)]
    static CenterPoint := Point(1272,535)
    static targetBtnRange := [Point(1730,160), Point(1794,938)]
    static teleportBtn := Point(2047, 1013)
    static ListRange := [Point(2021, 97), Point(2039, 902)]

    ; 等待到list打开
    static untilListOpen(){
        MouseClick(, this.chioceAreaBtn.x, this.chioceAreaBtn.y, ,0)
        time := A_TickCount
        while(!tool.pixelSearchPlus(this.ListRange[1], this.ListRange[2] ,'0xE4DDD2', , , 3)){
            Sleep(20)
            if(A_TickCount - time > 3000)
                return
        }
        Sleep(20)
    }

    ; 判断当前的地区
    static getNowArea(){
        for i in this.AreaBtn{
            if(Tool.pixelExist(i, '0xE4DDD2')){
                return A_Index
            }
        }
        ; 返回-1为失败，没有获取当前位置
        return -1
    }

    ; 传送到地区
    static teleportToArea(AreaId) {
        ; 如果并不在地图界面
        if (WhichGUI.whichGUI() != 2)
            return
        ; 打开地图切换列表
        this.untilListOpen()

        ; 对目标地点进行判断
        nowArea := this.getNowArea()
        if (nowArea == -1){
            ToolTip('没有找到当前所处的地点')
            SetTimer () => ToolTip(''), -4000
            return
        }
        else if (nowArea == AreaId){
            if (AreaId <= 4)
                MouseClick(, this.AreaBtn[5].x, this.AreaBtn[5].y, ,0)
            else{
                MouseClick(, this.AreaBtn[1].x, this.AreaBtn[1].y, ,0)
            }
            time := A_TickCount
            while(!tool.pixelExist(this.chioceAreaBtn,'0xE2DCCF')){
                Sleep(20)
                if(A_TickCount - time > 3000)
                    return
            }
            Sleep(50)
        }


        ; 正式切换目标地图
        this.untilListOpen()
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
        else if (tool.pixelExist(this.teleportBtn, '0xffcd33')){
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
    }
}