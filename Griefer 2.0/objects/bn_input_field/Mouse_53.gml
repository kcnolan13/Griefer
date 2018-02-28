/// @description get clicked
event_inherited()
    
if not modal_highlighted(id)
{
    exit_child = true
    active = false
    exit
}
    
if clicked exit
    clicked = 2

audio(snd_click,1)
active = true
auto_start = false

if auto_clear = true
{
    auto_clear = false
    text = ""
    str_cursor = "|"
}

keyboard_string = text

