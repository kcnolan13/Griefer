/// @description return to lobby
event_inherited()

if exit_child
{
    exit_child = false
    exit
}

net_manager.menu_mode = "lobby"
fade_out = true
xp_bar.alarm[1] = 0

