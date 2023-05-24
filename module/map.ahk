#Include ../core/point.ahk
#Include ../core/genshin.ahk
#Include ../core/whichGUI.ahk

class mapTeleport {
    static chioceAreaBtn := Point(Pos(2411, 1018))
    static AreaBtn := [Point(Pos(2115, 149)), Point(Pos(2115, 268)), Point(Pos(2115, 387)), Point(Pos(2115, 506)), Point(Pos(2115, 625)), Point(Pos(2115, 744)), Point(Pos(2115, 863))]
    static CenterPoint := Point(Pos(1272, 535))
    static targetBtnRange := [Point(Pos(1730, 160)), Point(Pos(1800, 1000))]
    static teleportBtn := Point(Pos(2047, 1013))
    static ListRange := [Point(Pos(2021, 97)), Point(Pos(2039, 902))]

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
        ; condition1plus : 蓝色锚点附近是否有深色（目的为找到List背景颜色）
        ; condition2 : 根据图片搜索，返回秘境的位置
        ; condition3 : 根据图片搜索，返回洞天锚点的位置
        
        ; 找到小箭头，将箭头坐标传入arrowTargetBtnX/Y
        condition0 := PixelSearch(&arrowTargetBtnX, &arrowTargetBtnY
            , this.targetBtnRange[1].x, this.targetBtnRange[1].y
            , this.targetBtnRange[2].x, this.targetBtnRange[2].y, '0xece5d8', 7)
        ; 提前声明，防止找不到
        condition1 := false
        condition1plus := false
        condition2 := false
        condition3 := false
        condition4 := false
        targetX1 := 0
        targetY1 := 0
        targetX2 := 0
        targetY2 := 0
        targetX3 := 0
        targetY3 := 0
        targetX4 := 0
        targetY4 := 0
        ArrayTargetX := []
        ArrayTargetY := []
        if(condition0){
            ; 在此基础上，找到传送锚点的蓝色，将传送锚点坐标传入targetBtnX/Y
            ; condition1 := PixelSearch(&targetBtnX, &targetBtnY
            ;     , arrowTargetBtnX, arrowTargetBtnY
            ;     , this.targetBtnRange[2].x, this.targetBtnRange[2].y, '0x2d91d9', 10)
            condition1 := PixelSearch(&targetX1, &targetY1
                , arrowTargetBtnX, arrowTargetBtnY
                , this.targetBtnRange[2].x, this.targetBtnRange[2].y, '0x2d91d9', 10)
            if(condition1){
                temp_point := Point(Pos(targetX1, targetY1))
                ; 查找锚点附近是否有List背景颜色（有待实验是否有效）
                condition1plus := Tool.pixelExist(temp_point, '0x1c242c', 40, 10)
                if(condition1plus){
                    ArrayTargetX.Push(targetX1)
                    ArrayTargetY.Push(targetY1)
                }
            }
            ; tempTargetX := 0
            ; tempTargetY := 0
            condition2 := ImageSearch(&targetX2, &targetY2, this.targetBtnRange[1].x, this.targetBtnRange[1].y, this.targetBtnRange[2].x, this.targetBtnRange[2].y, "*100 *Trans00ffff files\Domain.png")
            if(condition2){
                ArrayTargetX.Push(targetX2)
                ArrayTargetY.Push(targetY2)
            }
            condition3 := ImageSearch(&targetX3, &targetY3, this.targetBtnRange[1].x, this.targetBtnRange[1].y, this.targetBtnRange[2].x, this.targetBtnRange[2].y, "*100 *Transfecc00 files\HomeTeleport.png")
            if(condition3){
                ArrayTargetX.Push(targetX3)
                ArrayTargetY.Push(targetY3)
            }
            condition4 := ImageSearch(&targetX4, &targetY4, this.targetBtnRange[1].x, this.targetBtnRange[1].y, this.targetBtnRange[2].x, this.targetBtnRange[2].y, "*100 *Trans00ffff files\Domain2.png")
            if(condition4){
                ArrayTargetX.Push(targetX4)
                ArrayTargetY.Push(targetY4)
            }

            if(condition1plus || condition2 || condition3 || condition4){
                targetBtnX := ArrayTargetX[1]
                targetBtnY := Min(ArrayTargetY*)
            }
            

            
            ; MouseMove(targetX1, targetY1)
            ; MsgBox('condition1plus' condition1plus . 'condition2' condition2 . 'condition3' condition3)
            ; Pause

            ; if(condition1 && condition2){
            ; if(condition2){
            ;     if(tempTargetY <= targetBtnY){
            ;         targetBtnX := tempTargetX
            ;         targetBtnY := tempTargetY   
            ;     }
            ; }
            
        }

        ; ----------------------------------判断执行---------------------------------------
        
        if (tool.pixelExist(this.teleportBtn, '0xffcd33')){
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
        ; else if ((condition0 && condition1plus) || condition2) {
        else if (condition1 || condition2 || condition3 || condition4) {
            ; MsgBox('condition1' . condition1 . 'targetBtnX' . targetBtnX . 'targetBtnY' . targetBtnY)
            MouseClick(, targetBtnX, targetBtnY, ,0)
            Sleep(100)
            MouseClick(, this.teleportBtn.x, this.teleportBtn.y, ,0)
        }
        else{
            ToolTip("当前程序未找到目标传送点，请检查内容" . ' condition0:' . condition0 . ' condition1plus:'  . condition1plus . ' condition2:' .  condition2)
            SetTimer () => ToolTip(""), -1000
        }
    }
}