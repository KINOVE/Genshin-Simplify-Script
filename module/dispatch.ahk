#Include ../core/point.ahk
#Include ../core/genshin.ahk
#Include ../core/tool.ahk
#include ../core/whichGUI.ahk

class Dispatch {
    static sleep_time := 200
    
    ;四个派遣区域
    static p_area_range := [Point(Pos(208, 165)), Point(Pos(208, 237)), Point(Pos(208, 309)), Point(Pos(208, 382))]

    ;四个派遣区域的六个点位
    static p_characters := [
        [Point(Pos(883, 414)), Point(Pos(1135, 248)), Point(Pos(1375, 338)), Point(Pos(1439, 455)), Point(Pos(1063, 538)), Point(Pos(1495, 662))],
        [Point(Pos(883, 572)), Point(Pos(1047, 332)), Point(Pos(1283, 456)), Point(Pos(1131, 563)), Point(Pos(1493, 619)), Point(Pos(1051, 822))],
        [Point(Pos(1420, 283)),Point(Pos(1257, 350)), Point(Pos(1467, 441)), Point(Pos(1046, 700)), Point(Pos(906, 809)), Point(Pos(1150, 834))],
        [Point(Pos(1374, 248)),Point(Pos(1117, 301)), Point(Pos(1280, 380)), Point(Pos(1221, 563)), Point(Pos(1350, 616)), Point(Pos(1000, 643))]
    ]

    ; 设置点位派遣时间
    static p_time := Point(Pos(2400, 682))

    ;派遣检查
    static p_favourable := [Point(Pos(1200, 467)), Point(Pos(1200, 362)), Point(Pos(1200, 257)), Point(Pos(1200, 151))]

    ;按钮信息
    static p_button_pos := Point(Pos(2170, 1021))
    static color_dis := '0xFE5C5C'
    static color_yes := '0x99CC33'
    static color_ready := '0x313131'
    static color_in_yes := '0x99ff22'

    ; 每日任务
    static daily_reword_region := [Point(Pos(1750, 330)), Point(Pos(1800, 900))]

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
    
    static FindYellowTarget() {
        if(WhichGUI.whichGUI() == 4){
            return this.dispatch()
        }
        local targetx := 0, targety := 0
        isTargetExist := Tool.pixelSearchPlus(this.daily_reword_region[1], this.daily_reword_region[2], '0xFFCC32', &targetx, &targety, 10)
        if(isTargetExist){
            ; MouseMove(targetx, targety, 0)
            MouseClick( , targetx, targety, , 0)
            Sleep(1200)
            if(WhichGUI.whichGUI() == 4){
                return this.dispatch()
            }
            SendInput('{Space}')
            Sleep(3000)
            SendInput('{Esc}')
            Sleep(1500)
            SendInput('f')
            Sleep(1500)
            SendInput('{Space}')
            Sleep(1500)
            return this.FindYellowTarget() 
        }
        SendInput('Esc')
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        ToolTip('当前没有需要处理的任务',width/2, height/2)
        SetTimer () => ToolTip(''), -1000
    }
}
