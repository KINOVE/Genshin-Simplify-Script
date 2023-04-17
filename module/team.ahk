#Include ../core/point.ahk
#Include ../core/genshin.ahk

class Team {
    static green1 := Point(1105, 50)

    ; 右下角“快速编队”按钮
    static greenButtonPos := Point(1776,1021)
    static greenButtonColor := '0x99cc33'
    ; 右下角“出战”按钮
    static CheckBtn := Point(2125,1021)
    ; 中间顶部队伍显示区域
    static TeamIconRangeLeft := Point(1109, 39)
    static TeamIconRangeRight := Point(1542, 57)
    ; 左右两侧切换队伍按钮
    static ChangeToLeftBtn := Point(131, 527)
    static ChangeToRightBtn := Point(2418, 527)


    ; 切换队伍方法
    static changeTeam(teamId){
        global executing_function := true

        KeyWait('Control')
        KeyWait('3')
        ; 进入队伍切换界面(自行在StartThis.ahk中修改按键)
        global teamChangeBtn
        SendInput(teamChangeBtn)
        ; 每隔20毫秒，检测一次是否进入到了界面中
        Sleep(500)
        time := A_TickCount
        while (A_TickCount - time < 1500 ){
            Sleep(20)
            ; 如果超过了4000ms, 那么直接结束本次队伍切换
            if (PixelGetColor(this.green1.x, this.green1.y) != '0xffeb5f'){
                executing_function := false
                return
            }
        }
        while (PixelGetColor(this.greenButtonPos.x, this.greenButtonPos.y) != this.greenButtonColor){
            Sleep(20)
            ; 如果超过了4000ms, 那么直接结束本次队伍切换
            if (A_TickCount - time > 4000){
                executing_function := false
                return
            }
        }

        ; ***************************
        ; 检测到已经进入界面
        ; 开始识别队伍数量、当前队伍
        ; ***************************

        ; 当前高亮队伍的横纵坐标
        local nowTeamPosX, nowTeamPosY
        ; 正在识别中的左右两边的队伍图标位置，所有队伍的显示都在同一行，所以此处没有设新的Y轴变量
        local LeftTeamPosX , RightTeamPosX
        ; 临时接受找到的xy坐标，由于此处使用pixelSearch只是为了确认是否存在队伍，因此这两个变量没有后续用途
        local tempX, tempY
        ; count为队伍总数量
        local count := 1 
        ; nowTeam为当前队伍排第几
        local nowTeam

        ; 找到当前队伍所在位置
        PixelSearch(&nowTeamPosX, &nowTeamPosY, this.TeamIconRangeLeft.x, this.TeamIconRangeLeft.y, this.TeamIconRangeRight.x, this.TeamIconRangeRight.y, '0xFFFFFF', 0)
        
        ; 预设要寻找的左右两边的X轴位置变量
        RightTeamPosX := nowTeamPosX + 36
        LeftTeamPosX := nowTeamPosX - 36
        
        ; 循环向左寻找队伍，找到就计数+1
        while (PixelSearch(&tempX, &tempY, LeftTeamPosX - 20, nowTeamPosY - 20, LeftTeamPosX + 20, nowTeamPosY + 20, '0x5E78A1', 5)){
            LeftTeamPosX := LeftTeamPosX - 36
            count := count + 1
        }
        nowTeam := count
        ; 循环向右寻找队伍，找到就计数+1
        while (PixelSearch(&tempX, &tempY, RightTeamPosX - 20, nowTeamPosY - 20, RightTeamPosX + 20, nowTeamPosY + 20, '0x5E78A1', 5)){
            RightTeamPosX := RightTeamPosX + 36
            count := count + 1
        }

        ; ***************
        ; 切换队伍
        ; ***************

        ; 获取窗口长宽
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]

        ; 判断目标队伍ID是否不存在
        if (teamId > count){
            ToolTip("你选择的目标队伍为" . teamId . "但是实际队伍数量为" . count, width/2, height/2)
            SetTimer () => ToolTip(), -5000
            executing_function := false
            return
        }

        ; 如果目标队伍排序 <= 当前队伍
        if(teamId <= nowTeam){
            loop nowTeam - teamId{
                MouseClick(, this.ChangeToLeftBtn.x, this.ChangeToLeftBtn.y, ,0)
                Sleep(30)
            }
        }
        else{
            loop teamId - nowTeam{
                MouseClick(, this.ChangeToRightBtn.x, this.ChangeToRightBtn.y, ,0)
                Sleep(30)
            }
        }

        ; 选择队伍出击并退出
        MouseClick(, this.CheckBtn.x, this.CheckBtn.y, , 0)
        Sleep(100)
        SendInput('{Esc}')
        executing_function := false
    }
}