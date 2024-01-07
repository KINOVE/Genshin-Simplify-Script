#Include ../core/genshin.ahk
#Include ../core/point.ahk
#Include ../core/tool.ahk

class AutoBuy {
    static p_buy_button := Point(Pos(2190, 1020), Pos(0, 0))
    static p_max := Point(Pos(1500, 600), Pos(0, 0))
    static p_confirm := Point(Pos(1341, 780), Pos(0, 0))

    static refresh_pos() {
        this.p_buy_button.refresh_pos()
        this.p_confirm.refresh_pos()
        this.p_max.refresh_pos()
    }

    static autoBuy() {
        Tool.MClick(this.p_buy_button)
        Sleep(200)
        Tool.MClick(this.p_max)
        Sleep(200)
        Tool.MClick(this.p_confirm)
        Sleep(100)
        Click()
    }

}