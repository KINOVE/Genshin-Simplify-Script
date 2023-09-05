#Include core\core.ahk
#Include module\module.ahk
#HotIf Genshin.is_game_active() && WhichGUI.isScreen1()
; Ctrl + [1 ~ 0] 切换队伍
^1:: Team.changeTeam(1)
^2:: Team.changeTeam(2)
^3:: Team.changeTeam(3)
^4:: Team.changeTeam(4)
^5:: Team.changeTeam(5)
^6:: Team.changeTeam(6)
^7:: Team.changeTeam(7)
^8:: Team.changeTeam(8)
^9:: Team.changeTeam(9)
^0:: Team.changeTeam(0)
