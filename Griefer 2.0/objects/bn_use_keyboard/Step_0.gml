/// @description all dat ish
event_inherited()
label = text
life++

if global.using_gamepad
{
    text = keyboard_no
    alpha_max = 0.75
    active = false
}
else
{
    text = keyboard_yes
    alpha_max = 1
    active = true
}

