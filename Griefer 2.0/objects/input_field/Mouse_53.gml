/// @description toggle active
    
if alpha < 0.1 or popup_exists() exit

if !instance_place(x+__view_get( e__VW.XView, 0 ),y+__view_get( e__VW.YView, 0 ),cursor)
{
    input_active = false
    str_cursor = ""
    if id = chat_feed.entry
    {
        keyboard_string = ""
        input_string = ""
    }
}
else
{
    //don't let any input_fields auto-start after entry into any input field
    with input_field
        auto_started = true
    
    if not audio_is_playing(snd_click) and not input_active
        audio(snd_click,1)
    
    input_active = true
    keyboard_string = ""
    str_cursor = "|"

    if instantClear = true
    {
        instantClear = true
        input_string = ""
    }
}

