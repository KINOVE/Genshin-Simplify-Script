#Include point.ahk
#Include genshin.ahk

class Team {
    static greenButtonPos := Point(1776,1021)
    static greenButtonColor := '0x99cc33'
    static CheckBtn := Point(2125,1021)
    static TeamIconRangeLeft := Point(1109, 39)
    static TeamIconRangeRight := Point(1542, 57)
    static ChangeToLeftBtn := Point(131, 527)
    static ChangeToRightBtn := Point(2418, 527)
    static changeTeam(teamId){

        ; 进入队伍切换界面(因为我游戏中将键改成了g)
        SendInput('g')
        Sleep(2000)

        ; 每隔20毫秒，检测一次是否进入到了界面中
        time := A_TickCount
        while (PixelGetColor(this.greenButtonPos.x, this.greenButtonPos.y) != this.greenButtonColor){
            Sleep(20)
            ; 如果超过了2000ms, 那么直接结束本次队伍切换
            if (A_TickCount - time > 2000)
                return
        }

        ; 检测到已经进入界面
        ; 开始识别队伍数量、当前队伍
        local nowTeamPosX, nowTeamPosY
        local output := PixelSearch(&nowTeamPosX, &nowTeamPosY, this.TeamIconRangeLeft.x, this.TeamIconRangeLeft.y, this.TeamIconRangeRight.x, this.TeamIconRangeRight.y, '0xFFFFFF', 0)
        
        local tempNowTeamPosX := nowTeamPosX + 36
        nowTeamPosX := nowTeamPosX - 36
        local tempX, tempY
        ; count为队伍总数量
        local count := 1
        while (PixelSearch(&tempX, &tempY, nowTeamPosX - 20, nowTeamPosY - 20, nowTeamPosX + 20, nowTeamPosY + 20, '0x5E78A1', 5)){
            ; MouseMove(tempX, tempY, 0)
            nowTeamPosX := nowTeamPosX - 36
            ; MouseMove(nowTeamPosX, nowTeamPosY, 0)
            count := count + 1
        }
        ; nowTeam为当前队伍排第几
        local nowTeam := count
        while (PixelSearch(&tempX, &tempY, tempNowTeamPosX - 20, nowTeamPosY - 20, tempNowTeamPosX + 20, nowTeamPosY + 20, '0x5E78A1', 5)){
            tempNowTeamPosX := tempNowTeamPosX + 36
            count := count + 1
        }

        /***************
            切换队伍
         ***************/

        ; 获取窗口长宽
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]

        ; 判断目标队伍ID是否不存在
        if (teamId > count){
            ToolTip("你选择的目标队伍为" . teamId . "但是实际队伍数量为" . count, width/2, height/2)
            SetTimer () => ToolTip(), -5000
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


        ; ListVars
        ; Pause

        ; 确认队伍并退出
        MouseClick(, this.CheckBtn.x, this.CheckBtn.y, , 0)
        Sleep(100)
        SendInput('{Esc}')
    }
}