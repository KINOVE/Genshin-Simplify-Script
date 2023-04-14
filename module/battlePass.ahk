#Include ../core/point.ahk
#Include ../core/genshin.ahk

;纪行
class BattlePass {
    ; p1,p2分别为纪行界面的两个选项卡点位
    static p1 := Point(1185,55)
    static p2 := Point(1280,55)
    static upgrade := Point(2198,981)
    static exitBtn := Point(2420,48)

    ; 纪行结算并获取奖励
    static bp_award(){

        ; 检测当前所处的界面
        if (WhichGUI.whichGUI() != 1){
            ToolTip('当前可能处于特殊场景，无法使用纪行功能', )
            SetTimer () => ToolTip(''), -1000
            return
        }
            
        ; 待加入延时判断逻辑
        SendInput('{F4}')
        Sleep(700)
        MouseClick( , this.p2.x, this.p2.y, , 0)
        Sleep(300)

        ; 如果此时有exp可以领取
        static temp1,temp2
        if (PixelSearch( &temp1, &temp2, this.upgrade.x - 10, this.upgrade.y - 10 , this.upgrade.x + 10, this.upgrade.y + 10 , '0xdad9cd', 20)){
            MouseClick( , this.upgrade.x, this.upgrade.y, , 0)
            Sleep(50)
            MouseClick( , this.p1.x, this.p1.y, , 0)
            Sleep(100)
            ; 如果退出按钮的颜色正常，即未进入奖励窗口，则不休眠
            if (PixelGetColor(this.exitBtn.x, this.exitBtn.y) != '0xece5d8'){
                ; MouseMove(900, 900, 0)
                Sleep(1200)
                SendInput('{Esc}')
                ; loop 30{
                ;     MouseClick( , this.p1.x, this.p1.y, , 0)
                ; }
            }
        }
        ; if (WhichGUI.whichGUI == 1){
        ;     this.bp_award()
        ; }        
        ; 打开奖励领取界面
        ; 这里其实可以加一个延时等待判断(判断是否完成动画，是否可点击)的逻辑
        loop 3
            MouseClick( , this.p1.x, this.p1.y, , 0)
        Sleep(1000)
        ; 如果奖励领取按钮可触发
        if (PixelSearch( &temp1, &temp2, this.upgrade.x - 10, this.upgrade.y - 10 , this.upgrade.x + 10, this.upgrade.y + 10 , '0xdad9cd', 20))
            {MouseClick( , this.upgrade.x, this.upgrade.y, , 0)
            Sleep(50)
            SendInput('{Esc}')
            Sleep(200)
        }
        
        ; 退出界面
        SendInput('{Esc}')
    }
}