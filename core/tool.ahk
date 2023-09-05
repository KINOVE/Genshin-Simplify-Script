; 这个类里都是为了简化代码而编写的的方法
class Tool{

    ; 在目标点位附近搜素颜色相近的目标，可选择是否提供目标输出
    static pixelExist(target, colorId, range := 10, colorDeviation := 10, &outputX?, &outputY?){
        ; 假如提供了输出（被找到的点位坐标）
        if IsSet(outputX){
            return PixelSearch(&outputX, &outputY, target.x - range/2, target.y - range/2, target.x + range/2, target.y + range/2, colorId, colorDeviation)
        }
        else{
            temp := 0
            return PixelSearch(&temp, &temp, target.x - range/2, target.y - range/2, target.x + range/2, target.y + range/2, colorId, colorDeviation)
        }
    }

    ; 只是用于简化调用
    ; 提供区域A/B坐标，即可搜素范围内是否有满足要求的点
    static pixelSearchPlus(targetA, targetB, colorId, &outputX?, &outputY?,  colorDeviation := 10){
        if IsSet(outputX){
            return PixelSearch(&outputX, &outputY, targetA.x, targetA.y, targetB.x, targetB.y, colorId, colorDeviation)
        }
        else{
            local temp
            return PixelSearch(&temp, &temp, targetA.x, targetA.y, targetB.x, targetB.y, colorId, colorDeviation)
        }
    }

    ; 简化的鼠标移动
    static MMove(target, speed := 1){
        MouseMove(target.x, target.y, speed)
    }
    
    ; 简化的鼠标点击
    static MClick(target, speed := 1){
        MouseClick(,target.x, target.y, ,speed)
    }

    
    /*
        图片搜索
        static pointRange := [
            Point(Pos(0,0),Pos(56,998)),
            Point(Pos(0,0),Pos(98,1048))
        ]
        params := "*100"
        filePath := "files\team_select.png"
        Tool.imgSearch(&x,&y,pointRange,params,filePath,Color("#3b4255"))
        if (x != "" && y != "") {
            return true
        }
        return false
    */
    static imgSearch(&xOut,&yOut,pointRange,params,filePath,targetColor){
        if IsSet(targetColor) {
            if targetColor == "TransBlack" {
                c := 'Black'
            } else {
                c := SubStr(targetColor.c,3)
            }
            imgParams := Format("{1} *Trans{2} {3}", params, c, filePath)
        } else {
            imgParams := Format("{1} {2}",params,filePath)
        }
        res := ImageSearch( &xOut, &yOut,
             pointRange[1].x, pointRange[1].y,
             pointRange[2].x, pointRange[2].y,
             imgParams)
        return res
    }
}