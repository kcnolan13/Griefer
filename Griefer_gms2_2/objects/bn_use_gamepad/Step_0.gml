/// @description all dat ish
event_inherited()
label = text
life++

if global.gamepad_connected
{
    if global.using_gamepad
    {
        text = gamepad_yes
        alpha_max = 1
        highlightable = true
        active = true
    }
    else
    {
        text = gamepad_no
        alpha_max = 0.75
        highlightable = true
        active = false
    }
}
else 
{
    text = gamepad_disconnected
    alpha_max = 0.2
    highlightable = false
    active = false
}

