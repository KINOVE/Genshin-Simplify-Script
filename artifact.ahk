
;大概是圣遗物
;"快捷放入"按钮
;"强化按钮"
;"强化按钮"的颜色
;"详情"
;"强化"

class Artifact {
    static p_auto_add_button := Point(2321, 768)
    static p_enhance_button := Point(2184, 1020)
    static p_check_button := Point(1501, 758)
    static p_five_enhance_button := Point(2317, 1020)
    ; 详情页的lock按钮位置
    static p_lock := Point(2394,446)
    
    static color_enhance_button := '0x313131'
    static p_details_tab := Point(157, 154)
    static p_enhance_tab := Point(157, 225)
    static time_sleep := 40

    static refresh_pos() {
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        this.p_auto_add_button.refresh_pos(width, height)
        this.p_enhance_button.refresh_pos(width, height)
        this.p_check_button.refresh_pos(width, height)
        this.p_details_tab.refresh_pos(width, height)
        this.p_enhance_tab.refresh_pos(width, height)
    }

    static enhance_once() {
        this.refresh_pos()
        if PixelGetColor(this.p_enhance_button.x, this.p_enhance_button.y) = this.color_enhance_button {
            MouseClick(, this.p_auto_add_button.x, this.p_auto_add_button.y, , 0)
            Sleep(this.time_sleep)
            MouseClick(, this.p_enhance_button.x, this.p_enhance_button.y, , 0)
            Sleep(this.time_sleep)
            MouseClick(, this.p_details_tab.x, this.p_details_tab.y, , 0)
            Sleep(this.time_sleep)
            MouseClick(, this.p_enhance_tab.x, this.p_enhance_tab.y, , 0)
            Sleep(this.time_sleep)
            MouseMove(this.p_auto_add_button.x, this.p_auto_add_button.y, 0)
        }
    }
    
    static enhance_five() {
        this.refresh_pos()
        ; 随便点击一个位置去除圣遗物详情
        MouseClick(, this.p_five_enhance_button.x, this.p_five_enhance_button.y, , 0)
        Sleep(500)
        ; 点击强化
        MouseClick(, this.p_five_enhance_button.x, this.p_five_enhance_button.y, , 0)
        Sleep(this.time_sleep)
        ; 点击确认
        MouseClick(, this.p_check_button.x, this.p_check_button.y, , 0)
        Sleep(500)
        ; 强化跳过
        MouseClick(, this.p_details_tab.x, this.p_details_tab.y, , 0)
        Sleep(this.time_sleep)
        MouseClick(, this.p_enhance_tab.x, this.p_enhance_tab.y, , 0)
        Sleep(this.time_sleep)
        MouseClick(, this.p_details_tab.x, this.p_details_tab.y, , 0)
        Sleep(this.time_sleep)
    }

    static cancel_lock() {
        this.refresh_pos()
        static targetColorPositionX
        static targetColorPositionY
        static nowMousePosX
        static nowMousePosY
        MouseGetPos(&nowMousePosX, &nowMousePosY)
        if( PixelSearch(&targetColorPositionX,&targetColorPositionY,1442,320,1512,502,'0x9da0a7') || 
            PixelSearch(&targetColorPositionX,&targetColorPositionY,1442,320,1512,502,'0xff8a75')){
            MouseClick(,targetColorPositionX,targetColorPositionY,,0)
            SendInput("{Esc}")
        }
        else{
            ; 圣遗物强化界面下
            ; 转到详情页
            MouseClick(, this.p_details_tab.x, this.p_details_tab.y, , 0)
            Sleep(this.time_sleep)
            ; 取消lock
            MouseClick(, this.p_lock.x, this.p_lock.y, , 0)
            SendInput "{Esc}"
        }
        Sleep(20)
        MouseMove(nowMousePosX, nowMousePosY, 0)
    }
}