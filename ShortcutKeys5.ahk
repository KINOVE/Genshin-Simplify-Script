#Include StartThis.ahk
#HotIf Genshin.is_game_active() && (WhichGUI.whichGUI() == -1)
^Space::CheckOrQuit.check()