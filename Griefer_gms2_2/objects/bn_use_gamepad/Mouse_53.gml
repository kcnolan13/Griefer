/// @description all dat ish
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

    
if global.gamepad_connected
{
    printf("clicked: "+label)
    audio(snd_click,1)

    refresh_control_scheme(FL_GAMEPAD)
    global.forced_control_scheme = true
}

