#Include point.ahk
#Include genshin.ahk

class Skip {
    static skip_time(){
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        static p1 := Point(1859,1025)
        static p2 := Point(400,400)
        p1.refresh_pos(width, height)
        p2.refresh_pos(width, height)
        Sleep(20)
        MouseClick(,p1.x,p1.y,,0)
        ; Sleep(20)
        ; MouseClick(,p2.x,p2.y,,0)
        SendInput('{Esc}')
        SendInput('{Esc}')
        SendInput('{Esc}')
        ; Sleep(20)
        
        Sleep(1300)
        SendInput('{Esc}')
        Sleep(700)
        SendInput('{Esc}')
    }
    static skip_award(){
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        static p1 := Point(955,744)
        static p2 := Point(2418,50)
        static p3 := Point(659,507)
        p1.refresh_pos(width, height)
        p2.refresh_pos(width, height)
        p3.refresh_pos(width, height)
        SendInput('f')
        Sleep(300)
        MouseClick(,p1.x,p1.y,,0)
        Sleep(600)
        MouseClick(,p2.x,p2.y,,0)
        MouseClick(,p2.x,p2.y,,0)
        Sleep(250)
        MouseClick(,p2.x,p2.y,,0)
        Sleep(500)
        MouseMove(p3.x,p3.y,0)
    }
    static next_round(){
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        static p1 := Point(1324,978)
        static p2 := Point(1369,1021)
        p1.refresh_pos(width, height)
        p2.refresh_pos(width, height)
        static targetColorPositionX
        static targetColorPositionY
        if( PixelSearch(&targetColorPositionX,&targetColorPositionY,p1.x,p1.y,p2.x,p2.y,'0x323131') && 
            PixelSearch(&targetColorPositionX,&targetColorPositionY,p1.x,p1.y,p2.x,p2.y,'0xffcb32')){
            MouseClick(,targetColorPositionX, targetColorPositionY,,0)
            Sleep(1000)
            Click(2)
        }
    }
}