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

if global.using_gamepad
{
    restore_default_controls(FL_GAMEPAD)
}
else restore_default_controls(FL_KEYBOARD)

