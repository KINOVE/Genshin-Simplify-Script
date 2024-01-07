# Genshin-Simplify-Script

用于游戏 `GenshinImpact`（原神）PC 端的 `AutoHotKey` 快捷键脚本，简化游戏操作。

> 没死，也没打算放弃。只是最近在忙着找工作，没空更新。

## 分辨率适配情况

| 目标分辨率 | 屏幕比例 | 适配情况 |
| :--------: | :------: | :------: |
| 2560\*1080 |  `21:9`  |    ✅    |
| 3440\*1440 |  `21:9`  |    ✅    |
|     \*     |  `16:9`  |    ❕    |

> 1. 脚本内置按屏幕比自动适配的功能
> 2. `16:9`的屏幕比已经加入自动适配，但由于作者本人不用 16:9 的屏幕，目前未在各功能中加入点位
> 3. 关于多分辨率适配，可以参考[我的另一个项目的文档](https://github.com/KINOVE/StarRail-EasyScript/blob/master/files/docs/Multiresolution.md)（原理相同，能直接套用）
> 4. 可以提供各功能界面未压缩截图给我，或自行参考文档帮助完善

## 使用

- 基于[AutoHotKey2.0](https://www.autohotkey.com/)环境运行。
- 使用前请在`StartThis.ahk`的`按键`和`Setting`中进行调整

  （当然更推荐在`Genshin`中将游戏按键布局依照脚本中预设的按键调整游戏快捷键）

- 请使用管理员模式运行
- **启动`StartThis.ahk`即可**

## 注意事项

1. 由于个人游玩时屏幕为比例为`21:9`下的`2560 * 1080`，且暂无更换标准`16:9`屏幕的需求，因此本项目尚未满足`16:9`下的游戏需求<br>
2. 必须开启管理员模式运行，否则会导致脚本失效。
3. 脚本内容均为个人键位习惯服务，如有需要自行更改。
4. **脚本功能随时可能更改优化，键位也可能变动（后续考虑更换键位绑定功能）**
5. 有一个小问题是当你电脑很卡的时候，一些延时写的很极限的功能会出问题，请发 issue 反馈，我会想办法优化

## 功能介绍

### 全局

|       键位       |                     功能                      |
| :--------------: | :-------------------------------------------: |
|       `~`        |  切换模式（开启功能/关闭功能/飞行潜水模式）   |
|     `Alt+~`      | 生成鼠标所指点位的坐标/颜色信息（debug 功能） |
|  `Shift+Alt+R`   |     **调试功能，重载脚本，应用新的变动**      |
|    `Ctrl+Esc`    |       立刻关闭游戏和脚本（直接关进程）        |
| `Shift+Alt+左键` |                 循环点击左键                  |

### 大世界

|     键位      |                          功能                          |
| :-----------: | :----------------------------------------------------: |
|    长按`F`    |           高频循环触发 F 键，可用于快速拾取            |
|  长按`Space`  | 高频循环触发空格，可用于跳过对话、人物连跳、挣脱冻结等 |
|      `V`      |                      代替原有跳跃                      |
|    `alt+V`    |                    代替原有追踪任务                    |
|    `alt+P`    |    （在凯瑟琳菜单使用）收取每日任务奖励 & 快速派遣     |
|   `Ctrl+F4`   |                      纪行奖励领取                      |
| `Ctrl+[1~10]` |                快速切换队伍（目前无效）                |
|   `Ctrl+B`    |                   杂货店商品快速购买                   |

### 队伍界面

> （代替队伍切换功能，如果没有合适的快速切换方案，或者没有精力实现，就先用这个吧）

|     键位     |      功能      |
| :----------: | :------------: |
|   `Ctrl+A`   |   上一个配队   |
|   `Ctrl+D`   |   下一个配队   |
| `Ctrl+Space` | 确认切换到配队 |

### 地图界面

|       键位       |                  功能                  |
| :--------------: | :------------------------------------: |
|    `*Ctrl+T`     |            \*按下后快速传送            |
|   `Ctrl+[1~7]`   | 根据你的目前解锁地图状况，快速切换主城 |
| `Ctrl+Alt+[1~7]` |  根据你的目前解锁地图状况，传送到主城  |
|     `Ctrl+x`     |                  缩小                  |
|     `Ctrl+c`     |                  扩大                  |
|     `Ctrl+d`     |               删除标记点               |

> 快速传送功能并不稳定，识别方法待优化。
>
> 使用此功能请先点击目标传送点，弹出选择列表或者有黄色传送按钮的二级菜单，再按下`Ctrl+T`

### 圣遗物界面

|  键位   |            功能            |
| :-----: | :------------------------: |
| `alt+Q` | 快速使用四星及以下狗粮强化 |
| `alt+W` |   选择五星狗粮后快速强化   |
| `alt+E` |     快速加/减圣遗物锁      |

### 普通副本

|   键位   |        功能        |
| :------: | :----------------: |
| `Ctrl+F` | 快速领取圣遗物奖励 |
|   `N`    |     进入下一轮     |
| `Space`  |      退出副本      |

> 其他功能正在开发

## TODO

- [x] ~~重新组织项目结构，增强可读性~~
- [x] ~~快速传送兼容普通副本~~
- [x] ~~快速传送兼容所有副本~~
- [x] ~~快速传送兼容家园图标~~
- [x] ~~重构，同时兼容支持`21:9`和`16:9`方案~~
- [x] ~~圣遗物副本逻辑优化~~
- [ ] 通过 GUI 进行快捷键触发管理
- [ ] 完善一下按键提示显示方案吧，左边的 Tooltip 该更新了

## 补充说明

> 本项目灵感来自于群友已停止维护的脚本，感谢群友（ID：重新做人）分享的脚本资料。~~虽然现在已经看不出来前身的样子了~~

1. 脚本经常需要针对功能进行调整，所以暂时不考虑发布包含`.exe`的`Release`。
2. 懒狗 mhy，什么时候能优化一下 PC 屎一样的快捷键。好多界面都没有快捷键，切队伍还等 3 秒，我真服了。
3. 有分享欲不一定是好事，普通人谈脚本色变，原神又太出圈，分享易被小鬼泼脏水。~~忍住啊我自己！~~
4. 本脚本无对游戏注入的行为，无利益相关，小鬼退散！
