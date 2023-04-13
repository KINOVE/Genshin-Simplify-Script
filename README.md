# Genshin_ahk_script
本项目是一套用于优化个人游戏体验，减少冗余操作的自用AHK脚本。
~~虽然写的很烂，包括Readme，我知道的~~
> ⚠ 项目基于群友（ID：重新做人）分享的脚本资料开发（~~旧脚本不再维护了有些可惜~~）

## 运行环境
- 基于[AutoHotKey2.0](https://www.autohotkey.com/)环境运行。
- 请使用管理员模式运行
- **启动`main.ahk`即可**

## 注意事项
1. 由于个人游玩时屏幕为比例为`21:9`下的`2560 * 1080`，且暂无更换标准`16:9`屏幕的需求，因此本项目尚未满足`16:9`下的游戏需求<br>
   （ ~~其实你只要自己改每个类里里写在前面的坐标就可以了，但是工程量有点大~~ ）
2. 必须开启管理员模式运行，否则会导致脚本失效。
3. 脚本内容均为个人键位习惯服务，如有需要自行更改。
4. **脚本功能随时可能更改优化，键位也可能变动（后续考虑更换键位绑定功能）**
5. 有一个小问题是当你电脑很卡的时候，一些延时写的很极限的功能会出问题，请发issue反馈，我会想办法优化

## 功能介绍
> 懒狗mhy，什么时候能优化一下PC屎一样的快捷键。好多界面都不加空格前进，切队伍还等3秒，我真服了。

### 全局
|     键位      |                 功能                 |
| :-----------: | :----------------------------------: |
| `Alt+Shift+R` | **调试功能，重载脚本，应用新的变动** |
|  `Ctrl+Esc`   |   立刻关闭游戏和脚本（直接关进程）   |

### 大世界
|     键位      |                          功能                          |
| :-----------: | :----------------------------------------------------: |
|    长按`F`    |            高频循环触发F键，可用于快速拾取             |
|  长按`Space`  | 高频循环触发空格，可用于跳过对话、人物连跳、挣脱冻结等 |
|      `V`      |                      代替原有跳跃                      |
|    `alt+V`    |                    代替原有追踪任务                    |
|    `alt+P`    |                        快速派遣                        |
|   `Ctrl+F4`   |                      纪行奖励领取                      |
| `Ctrl+[1~10]` |                      快速切换队伍                      |



### 地图界面
|     键位     |                                            功能                                            |
| :----------: | :----------------------------------------------------------------------------------------: |
|   `Ctrl+T`   | （不稳定，目前只支持普通蓝色传送点以及七天神像）<br>（在鼠标选中传送点位后）按下后快速传送 |
| `Ctrl+[1~7]` |                    （在地图界面）根据你的目前解锁地图状况，快速切换主城                    |

### 圣遗物界面
|  键位   |                     功能                     |
| :-----: | :------------------------------------------: |
| `alt+Q` | 在圣遗物强化界面，快速使用四星及以下狗粮强化 |
| `alt+W` |   在圣遗物强化界面，选择五星狗粮后快速强化   |
| `alt+E` |     在圣遗物强化界面，快速加/减圣遗物锁      |

### 普通副本
| 键位  |         功能         |
| :---: | :------------------: |
|  `~`  |  快速领取圣遗物奖励  |
| `F1`  | 圣遗物副本进入下一轮 |


> 其他功能正在开发


## TODO
- [x] 重新组织项目结构，增强可读性
- [ ] 圣遗物副本逻辑优化（往后稍稍先，最近在打突破材料）
- [ ] 同时兼容支持`21:9`和`16:9`方案

> 写脚本需要面对的游戏情况太复杂了，而且短时间内很多不好复现情景。
> 
> 所以我打算写个WPF项目，通过录屏来记录一些不好复现的流程，导入之后，标点时间轴计算每个功能之间的延时，获取到对应点位的颜色……
> 
> 不过其他事情比较多，WPF也不是很熟，慢慢来。
