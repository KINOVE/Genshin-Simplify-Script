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
}