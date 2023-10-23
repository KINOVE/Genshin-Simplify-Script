#Include core.ahk
; 用于快速提取点位和颜色信息
Class PointExtractor {
    ; model -> 
    ; 1.Point(Pos(x,y)) Color() 
    ; 2.Color()
    ; 3.Pos()
    static model := 3
    static getPoint(){
        MouseGetPos(&x,&y)
        c := PixelGetColor(x,y)
        c := "#" . SubStr(c,3,6)

        x := this.transX_1440to1080(x)
        y := this.transY_1440to1080(y)

        switch this.model {
            case 1:
                A_Clipboard := Format('Point(Pos({1},{2}))`nColor("{3}")',x,y,c)
            case 2:
                A_Clipboard := Format('Color("{3}")',c)
            case 3:
                A_Clipboard := Format('Pos({1},{2})',x,y)
        }
    }

    static searchColor(){
        static target := Color("#ECE5D8")
        width := Genshin.game_size.width
        height := Genshin.game_size.height
        if PixelSearch(&x,&y,0,0,width,height,target.c) {
        ; if PixelSearch(&x,&y,1430,100,width,height,target.c,10) {
        ; if PixelSearch(&x,&y,32,513,70,552,target.c) {
            MouseMove(x,y,0)
            c := PixelGetColor(x,y)
            c := "#" . SubStr(c,3,6)
            A_Clipboard := Format('Point(Pos({1},{2}))`nColor("{3}")',x,y,c)
        }
    }

    static transX_1440to1080(x){
        return Floor(x/3440*2560)
    }

    static transY_1440to1080(y){
        return Floor(y/1440*1080)
    }
}