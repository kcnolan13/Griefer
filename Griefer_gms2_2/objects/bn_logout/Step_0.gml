/// @description adjust what this does based on the situation
event_inherited()

if objVarRead(net_manager,"game_mode") = "no_mode" or room = rm_menu
{
    text = txt_logout
    image = icon_quit
}
else
{
    text = txt_leave_match
    image = icon_back
}


