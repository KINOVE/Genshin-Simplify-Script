#Include ../core/point.ahk
#Include ../core/genshin.ahk
#Include ../core/tool.ahk
#include ../core/whichGUI.ahk

class Dispatch {
    static sleep_time := 200
    
    ;四个派遣区域
    static p_area_range := [
        Point(Pos(208, 165),Pos(126, 165)), 
        Point(Pos(208, 237),Pos(126, 237)), 
        Point(Pos(208, 309),Pos(126, 309)), 
        Point(Pos(208, 382),Pos(126, 382)), 
        Point(Pos(208, 455),Pos(126, 455))
    ]

    ;四个派遣区域的六个点位
    static p_characters := [
        [
            ; 蒙德
            ; files\dispatch\1-蒙德.png
            Point(Pos(883, 414)), 
            Point(Pos(1135, 248)), 
            Point(Pos(1375, 338)), 
            Point(Pos(1439, 455)), 
            Point(Pos(1063, 538)), 
            Point(Pos(1495, 662))
        ],
        [
            ; 璃月
            ; files\dispatch\2-璃月.png
            Point(Pos(883, 572),Pos(564,566)), 
            Point(Pos(1047, 332),Pos(725,330)), 
            Point(Pos(1283, 456),Pos(961,450)), 
            Point(Pos(1131, 563),Pos(811,559)),
            Point(Pos(1493, 619),Pos(1173,615)), 
            Point(Pos(1051, 822),Pos(730,816))
        ],
        [
            ; 稻妻
            ; files\dispatch\3-稻妻.png
            Point(Pos(1420, 283),Pos(1100,284)),
            Point(Pos(1257, 350),Pos(941,351)), 
            Point(Pos(1467, 441),Pos(1150,437)), 
            Point(Pos(1046, 700),Pos(723,694)), 
            Point(Pos(906, 809),Pos(586,801)), 
            Point(Pos(1150, 834),Pos(828,832))
        ],
        [
            ; 须弥
            ; files\dispatch\4-须弥.png
            Point(Pos(1374, 248),Pos(1053,244)),
            Point(Pos(1117, 301),Pos(795,294)), 
            Point(Pos(1280, 380),Pos(960,373)), 
            Point(Pos(1221, 563),Pos(899,559)), 
            Point(Pos(1350, 616),Pos(1029,612)), 
            Point(Pos(1000, 643),Pos(681,637))
        ],
        [
            ; 枫丹
            ; files\dispatch\5-枫丹.png
            Point(Pos(977, 324),Pos(652,316)), 
            Point(Pos(1376, 256),Pos(1051,247)), 
            Point(Pos(1218, 466),Pos(894,456)), 
            Point(Pos(941, 559),Pos(618,555)), 
            Point(Pos(1351, 596),Pos(1031,593)), 
            Point(Pos(1148, 652),Pos(824,640))
        ]
    ]

    

    ; 设置点位派遣时间
    static p_time := Point(Pos(2400, 682),Pos(1804,681))

    ;派遣检查
    static p_favourable := [
        Point(Pos(1200, 467),Pos(878, 467)), 
        Point(Pos(1200, 362),Pos(878, 362)), 
        Point(Pos(1200, 257),Pos(878, 257)), 
        Point(Pos(1200, 151),Pos(878, 151))
    ]

    ;按钮信息
    static p_button_pos := Point(Pos(2170, 1021),Pos(1601,1021))
    static color_dis := Color("#FE5C5C").c
    static color_yes := Color("#99CC33").c
    static color_ready := Color("#313131").c
    static color_in_yes := Color("#99ff22").c

    ; 每日任务
    static daily_reword_region := [
        Point(Pos(1750, 330), Pos(1335, 330)), 
        Point(Pos(1800, 900), Pos(1471, 900))
    ]

    static refresh_pos() {
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        
        ; 刷新点位坐标---------------------------------------

        ; 区域选择
        for i in this.p_area_range {
            i.refresh_pos()
        }
        this.p_button_pos.refresh_pos()

        ; 各区域点位
        for i in this.p_characters{
            for j in i{
                j.refresh_pos()
            }
        }
        
        ; 派遣加成
        for i in this.p_favourable {
            i.refresh_pos()
        }
    }

    ; 选择点位要派遣的角色
    static sendpatch() {
        ;等待界面打开
        Sleep(500)
        flag := false
        for p in this.p_favourable{
            if PixelGetColor(p.x, p.y) = this.color_in_yes {
                flag := true
                Sleep(50)
                MouseClick(,p.x, p.y,,0)
            }
        }

        if flag == false {
            for p in this.p_favourable {
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

    ; 派遣任务
    static dispatch() {
        ; 刷新所有点位
        this.refresh_pos()

        ;点击第2区域
        this.changeArea(2)
        this.checkifpatch(2,1)
        this.checkifpatch(2,4)
        this.checkifpatch(2,3)

        this.changeArea(5)
        this.checkifpatch(5,3)
        this.checkifpatch(5,5)

        ;退出
        SendInput("{Esc}")
    }
    
    static FindYellowTarget() {
        if(WhichGUI.whichGUI() == 4){
            return this.dispatch()
        }
        local targetx := 0, targety := 0
        isTargetExist := Tool.pixelSearchPlus(this.daily_reword_region[1], this.daily_reword_region[2], Color('#FFCC32').c, &targetx, &targety, 10)
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
