/// @description adjust what this does based on the situation
event_inherited()

if room = rm_menu
    text = txt_menu
else
    text = txt_lobby

if net_manager.menu_mode != "play" and net_manager.menu_mode != "lobby"
    active = false
else
    active = true

