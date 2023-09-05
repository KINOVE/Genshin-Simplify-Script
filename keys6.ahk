#Include core\core.ahk
#Include module\module.ahk
; 地图界面下生效
#HotIf Genshin.is_game_active() && WhichGUI.isScreen2()

; 缩小
^X::{
    MouseGetPos(&x,&y)
    Tool.MClick(Point(Pos(0,0),Pos(46,651)))
    MouseMove(x,y,0)
}

; 放大
^C::{
    MouseGetPos(&x,&y)
    Tool.MClick(Point(Pos(0,0),Pos(47,421)))
    MouseMove(x,y,0)
}

; 删除标点
^D::{
    p_delete_btn := Point(,Pos(1476,1012))
    c_delete_btn := Color("#FE5C5C").c
    if Tool.pixelExist(p_delete_btn, c_delete_btn) {
        MouseGetPos(&x,&y)
        Tool.MClick(p_delete_btn)
        MouseMove(x,y,0)
    }
}

; Ctrl + Alt + [1 ~ 8] 传送到各地区（注意：此功能会根据游戏进度不同导致部分地区未解锁，请按实际情况选择）
; 蒙德
; 璃月
; 稻妻
; 须弥
; 枫丹
; 渊下宫
; 层岩
; 尘歌壶
!^1:: mapTeleport.teleportToArea(1)
!^2:: mapTeleport.teleportToArea(2)
!^3:: mapTeleport.teleportToArea(3)
!^4:: mapTeleport.teleportToArea(4)
!^5:: mapTeleport.teleportToArea(5)
!^6:: mapTeleport.teleportToArea(6)
!^7:: mapTeleport.teleportToArea(7)
!^8:: mapTeleport.teleportToArea(8)

; Ctrl + [1 ~ 8] 切换到各地区（注意：此功能会根据游戏进度不同导致部分地区未解锁，请按实际情况选择）
; 蒙德
; 璃月
; 稻妻
; 须弥
; 枫丹
; 渊下宫
; 层岩
; 尘歌壶
^1:: mapTeleport.switchToArea(1)
^2:: mapTeleport.switchToArea(2)
^3:: mapTeleport.switchToArea(3)
^4:: mapTeleport.switchToArea(4)
^5:: mapTeleport.switchToArea(5)
^6:: mapTeleport.switchToArea(6)
^7:: mapTeleport.switchToArea(7)
^8:: mapTeleport.switchToArea(8)