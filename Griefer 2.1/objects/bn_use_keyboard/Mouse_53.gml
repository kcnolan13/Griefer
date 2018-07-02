/// @description all dat ish
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

printf("clicked: "+label)
audio(snd_click,1)

refresh_control_scheme(FL_KEYBOARD)
global.forced_control_scheme = true

