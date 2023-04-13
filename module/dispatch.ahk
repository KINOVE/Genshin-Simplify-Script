#Include ../core/point.ahk
#Include ../core/genshin.ahk

class Dispatch {
    static sleep_time := 200
    
    ;四个派遣区域
    static p_area_range := [Point(208, 165), Point(208, 237), Point(208, 309), Point(208, 382)]

    ;四个派遣区域的六个点位
    static p_characters := [
        [Point(883,414), Point(1135,248), Point(1375,338), Point(1439,455), Point(1063,538), Point(1495,662)],
        [Point(883,572), Point(1047,332), Point(1283,456), Point(1131,563), Point(1493,619), Point(1051,822)],
        [Point(1420,283),Point(1257,350), Point(1467,441), Point(1046,700), Point(906,809), Point(1150,834)],
        [Point(1374,248),Point(1117,301), Point(1280,380), Point(1221,563), Point(1350,616), Point(1000,643)]
    ]

    ; 设置点位派遣时间
    static p_time := Point(2400, 682)

    ;派遣检查
    static p_favourable := [Point(1200,467), Point(1200,362), Point(1200,257), Point(1200,151)]

    ;按钮信息
    static p_button_pos := Point(2170,1021)
    static color_dis := '0xFE5C5C'
    static color_yes := '0x99CC33'
    static color_ready := '0x313131'
    static color_in_yes := '0x99ff22'
    static refresh_pos() {
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        
        ; 刷新点位坐标---------------------------------------

        ; 区域选择
        for i in this.p_area_range {
            i.refresh_pos(width, height)
        }
        this.p_button_pos.refresh_pos(width, height)

        ; 各区域点位
        for i in this.p_characters{
            for j in i{
                j.refresh_pos(width, height)
            }
        }
        
        ; 派遣加成
        for i in this.p_favourable {
            i.refresh_pos(width, height)
        }
    }

    ; 选择点位要派遣的角色
    static sendpatch() {
        ;等待界面打开
        Sleep(500)
        for p in this.p_favourable{
            if PixelGetColor(p.x, p.y) = this.color_in_yes {
                Sleep(50)
                MouseClick(,p.x, p.y,,0)
            }
        }
        
        ;等待界面关闭
        Sleep(200)
    }
    
    ; 检查是否需要派遣
    static checkifpatch( AreaId, PointId) {

        ; 切换对应区域，对应点位的详情
        MouseClick(,this.p_characters[Areaid][PointId].x,this.p_characters[Areaid][PointId].y,,0) 
        Sleep(100)
        MouseClick(, this.p_time.x, this.p_time.y, , 0)
        
        if (PixelGetColor(this.p_button_pos.x, this.p_button_pos.y) = this.color_yes) {
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            Sleep(this.sleep_time)
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            Sleep(this.sleep_time)
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            this.sendpatch()
        }
        else if (PixelGetColor(this.p_button_pos.x, this.p_button_pos.y) = this.color_ready) {
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            this.sendpatch()
        }
    }

    ; 切换地区。
    static changeArea(AreaId){
        Sleep(50)
        MouseClick(, this.p_area_range[AreaId].x, this.p_area_range[AreaId].y, , 0)
        Sleep(50)
    }

    static dispatch() {
        ; 刷新所有点位
        this.refresh_pos()

        ;点击第2区域
        this.changeArea(2)
        this.checkifpatch(2,1)
        this.checkifpatch(2,4)
        this.checkifpatch(2,3)

        ;点击第3区域
        this.changeArea(3)
        this.checkifpatch(3,6)

        ;点击第4区域
        this.changeArea(4)
        this.checkifpatch(4,3)

        ;退出
        SendInput("{Esc}")
    }
}