#Include ../core/genshin.ahk

; 圣遗物强化/加减锁功能
; "快捷放入"按钮
; "强化按钮"
; "强化按钮"的颜色
; "详情"
; "强化"

class Artifact {
    static p_auto_add_button := Point(Pos(2321, 768), Pos(1830, 768))
    static p_enhance_button := Point(Pos(2184, 1020), Pos(1616, 1020))
    static p_check_button := Point(Pos(1501, 758), Pos(1018, 758))
    static p_five_enhance_button := Point(Pos(2317, 1020), Pos(1745, 1020))
    ; 详情页的lock按钮位置
    static p_lock := Point(Pos(2394,446), Pos(1827,446))
    
    static color_enhance_button := '0x313131'
    static p_details_tab := Point(Pos(157, 154), Pos(157, 154))
    static p_enhance_tab := Point(Pos(157, 225), Pos(157, 225))
    static time_sleep := 40

    static LockP1 := Point(Pos(1442, 320), Pos(1141, 320))
    static LockP2 := Point(Pos(1512, 502), Pos(1180, 502))

    static refresh_pos() {
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]

        
        this.p_auto_add_button.refresh_pos()
        this.p_enhance_button.refresh_pos()
        this.p_check_button.refresh_pos()
        this.p_five_enhance_button.refresh_pos()
        this.p_lock.refresh_pos()
        this.p_details_tab.refresh_pos()
        this.p_enhance_tab.refresh_pos()
        this.LockP1.refresh_pos()
        this.LockP2.refresh_pos()
        ; MsgBox(this.p_enhance_button.x)
    }

    static enhance_once() {
        this.refresh_pos()
        ; MsgBox(this.p_enhance_button.x)
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
            return
        }
        MsgBox(
            PixelGetColor(this.p_enhance_button.x, this.p_enhance_button.y) . 
            '`n' . 
            this.p_enhance_button.x . ' -- ' . this.p_enhance_button.y
        )
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
        ; MouseClick(, this.p_details_tab.x, this.p_details_tab.y, , 0)
        ; Sleep(this.time_sleep)
    }

    static cancel_lock() {
        this.refresh_pos()
        static targetColorPositionX := 0 
        static targetColorPositionY := 0 
        static nowMousePosX := 0 
        static nowMousePosY := 0 
        
        MouseGetPos( &nowMousePosX, &nowMousePosY)
        ; 1141,320:1180.502
        if (
            PixelSearch( &targetColorPositionX, &targetColorPositionY, this.LockP1.x, this.LockP1.y, this.LockP2.x, this.LockP2.y, '0xff8a75', 20) ||
            PixelSearch( &targetColorPositionX, &targetColorPositionY, this.LockP1.x, this.LockP1.y, this.LockP2.x, this.LockP2.y, '0x9da0a7', 20)
        )
        {
            MouseClick( , targetColorPositionX, targetColorPositionY, , 0)
            SendInput("{Esc}")
        }
        else{
            ; 圣遗物强化界面下
            ; 转到详情页
            MouseClick(, this.p_details_tab.x, this.p_details_tab.y, , 0)
            Sleep(this.time_sleep)
            ; 取消lock
            MouseClick(, this.p_lock.x, this.p_lock.y, , 0)
            Sleep(this.time_sleep)
            SendInput("{Esc}")
        }
        Sleep(20)
        MouseMove( nowMousePosX, nowMousePosY, 0)
    }
}