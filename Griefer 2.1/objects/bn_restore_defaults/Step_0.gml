/// @description all dat ish
event_inherited()
label = text
life++

if life > 1
{
    if not capturing
        text = text_normal
    else
        text = text_capturing
}

