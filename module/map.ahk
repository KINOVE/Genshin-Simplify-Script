#Include ../core/point.ahk
#Include ../core/genshin.ahk
#Include ../core/whichGUI.ahk

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
        Sleep(20)
        MouseClick(, this.AreaBtn[AreaId].x, this.AreaBtn[AreaId].y, ,0)
        Sleep(20)
        MouseClick(, this.CenterPoint.x, this.CenterPoint.y, ,0)
        Sleep(400)
        this.fastTeleport()
    }

    ; 快速传送
    static fastTeleport(){
        
        ; 等待完整界面打开
        Sleep(100)
        
        ; 如果并不在地图界面
        if (WhichGUI.whichGUI() != 2)
            return

        ; ----------------------------------变量准备--------------------------------------

        ; 存放传送锚点坐标
        targetBtnX := 0
        targetBtnY := 0
        
        ; 存放List左侧的小箭头坐标
        arrowTargetBtnX := 0
        arrowTargetBtnY := 0

        ; ----------------------------------条件准备--------------------------------------

        ; (因为搜索语句太乱了，提前放在前面存入变量)
        ; condition0 : 是否存在小箭头
        ; condition1 : 是否存在蓝色的传送锚点
        ; condition2 : 蓝色锚点附近是否有深色（目的为找到List背景颜色）

        ; 找到小箭头，将箭头坐标传入arrowTargetBtnX/Y
        condition0 := PixelSearch(&arrowTargetBtnX, &arrowTargetBtnY
            , this.targetBtnRange[1].x, this.targetBtnRange[1].y
            , this.targetBtnRange[2].x, this.targetBtnRange[2].y, '0xece5d8', 7)
        if(condition0){
            ; 在此基础上，找到传送锚点的蓝色，将传送锚点坐标传入targetBtnX/Y
            condition1 := PixelSearch(&targetBtnX, &targetBtnY
                , arrowTargetBtnX, arrowTargetBtnY
                , this.targetBtnRange[2].x, this.targetBtnRange[2].y, '0x2d91d9', 10)
            if(condition1){
                temp_point := Point(targetBtnX, targetBtnY)
                ; 查找锚点附近是否有List背景颜色（有待实验是否有效）
                condition2 := Tool.pixelExist(temp_point, '0x1c242c', 40, 10)
            }
        }

        ; ----------------------------------判断执行---------------------------------------
        
        if (tool.pixelExist(this.teleportBtn, '0xffcd33')){
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
        else if (condition0 && condition2) {
            MouseClick(, targetBtnX, targetBtnY, ,0)
            Sleep(100)
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
        else{
            ToolTip("当前程序未找到目标传送点，请检查内容")
            SetTimer () => ToolTip(""), -1000
        }
    }
}