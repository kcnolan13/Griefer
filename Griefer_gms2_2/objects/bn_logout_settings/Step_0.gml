/// @description all dat ish
event_inherited()
label = text
life++

alpha_max = 1
highlightable = true

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

if not instance_exists(modal_controls)
    fade_out = true


