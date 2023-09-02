#Include ../core/Color.ahk
#Include ../core/point.ahk
#Include ../core/tool.ahk
class CheckOrQuit {
    static pointRange := [
        ; todo -> fix
        Point(Pos(0,0),Pos(544,972)),
        Point(Pos(0,0),Pos(1356,1033)),
    ]
    static quit(){
        params := "*100"
        filePath := "files\check_or_quit\quit.png"
        Tool.imgSearch(&x,&y,this.pointRange,params,filePath,Color("#3ba3e6"))
        if (x != "" && y != "") {
            MouseClick(,x,y,,0)
        }
    }
    static check(){
        params := "*100"
        filePath := "files\check_or_quit\check.png"
        Tool.imgSearch(&x,&y,this.pointRange,params,filePath,Color("#f8c532"))
        if (x != "" && y != "") {
            MouseClick(,x,y,,0)
        }
    }
}