#Include point.ahk
#Include genshin.ahk

class Team {
    static greenButtonPos := Point(1776,1021)
    static greenButtonColor := '0x99cc33'
    static teamButtonPos := Point(150,1021)
    static teamPos1 := Point(473,173)
    static teamPos2 := Point(473,350)
    static teamPos3 := Point(473,527)
    static teamPos4 := Point(473,704)
    static teamPos5 := Point(473,881)
    static innerCheckBtn := Point(146,1020)
    static CheckBtn := Point(2125,1021)
    static changeTeam(teamId){
        ;进入队伍切换界面(因为我游戏中将键改成了g)
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
        ;检测到已经进入界面
        MouseClick(,this.teamButtonPos.x, this.teamButtonPos.y, , 0)
        Sleep(100)
        MouseMove(350, 350, 0)
        loop 100
            MouseClick('WU',,, 2)
        Sleep(400)
        if (teamId > 4){
            ;这里有个坑，最好是先切换到第一个队伍，再切换到后续队伍
            ;当你在第5个队伍想切换第六个队伍时，点击第五个队伍并不会向下正确滚动页面，导致卡在第五个队伍
            if(teamId > 5){
                MouseClick(, this.teamPos1.x, this.teamPos1.y, , 0)
                MouseClick(, this.innerCheckBtn.x, this.innerCheckBtn.y, , 0)
                Sleep(50)
                MouseClick(,this.teamButtonPos.x, this.teamButtonPos.y, , 0)
                Sleep(100)
                MouseMove(350, 350, 0)
                loop 100
                    MouseClick('WU',,, 2)
                Sleep(400)
            }
            loop teamId-4{
                MouseClick(, this.teamPos5.x, this.teamPos5.y, , 0)
                Sleep(100)
            }
        } else{
            switch teamId {
                case 1: MouseClick(, this.teamPos1.x, this.teamPos1.y, , 0)
                case 2: MouseClick(, this.teamPos2.x, this.teamPos2.y, , 0)
                case 3: MouseClick(, this.teamPos3.x, this.teamPos3.y, , 0)
                case 4: MouseClick(, this.teamPos4.x, this.teamPos4.y, , 0)
            }
        }
        MouseClick(, this.innerCheckBtn.x, this.innerCheckBtn.y, , 0)
        Sleep(50)
        MouseClick(, this.CheckBtn.x, this.CheckBtn.y, , 0)
        SendInput('{Esc}')
    }
}