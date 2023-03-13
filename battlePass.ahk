#Include point.ahk
#Include genshin.ahk

;纪行
class BattlePass {
    static p1 := Point(1185,55)
    static p2 := Point(1280,55)
    static upgrade := Point(2198,981)
    static bp_award(){
        SendInput('{F4}')
        Sleep(700)
        MouseClick( , this.p2.x, this.p2.y, , 0)
        Sleep(300)
        static temp1,temp2
        if (PixelSearch( &temp1, &temp2, this.upgrade.x - 10, this.upgrade.y - 10 , this.upgrade.x + 10, this.upgrade.y + 10 , '0xdad9cd', 20)){
            MouseClick( , this.upgrade.x, this.upgrade.y, , 0)
            MouseClick( , this.p1.x, this.p1.y, , 0)
            Sleep(5000)
        }
        MouseClick( , this.p1.x, this.p1.y, , 0)
        MouseClick( , this.p1.x, this.p1.y, , 0)
        MouseClick( , this.p1.x, this.p1.y, , 0)
        if (PixelSearch( &temp1, &temp2, this.upgrade.x - 10, this.upgrade.y - 10 , this.upgrade.x + 10, this.upgrade.y + 10 , '0xdad9cd', 20)){
            MouseClick( , this.upgrade.x, this.upgrade.y, , 0)
        }
        SendInput('{Esc}')
    }
}