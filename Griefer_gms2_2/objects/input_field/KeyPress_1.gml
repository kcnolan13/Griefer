/// @description add text

if not input_active and not auto_started and alpha > 0.1 and room = rm_login
{
    if room = rm_login //and bn_login_user.field_username != id
        return false
    
    auto_started = true
    if not audio_is_playing(snd_click) and not input_active
    audio(snd_click,1)

    input_active = true
    str_cursor = "|"

    if instantClear = true
    {
        instantClear = true
        input_string = ""
    }
}

if input_active=true and alpha > 0.1
{
    if instantClear = true
    {
        instantClear = false
        input_string = ""
    }

    if string_length(keyboard_string) < max_length
    {
        input_string = string_replace_all(keyboard_string,"#","")
    } else {
        keyboard_string = string_replace_all(input_string,"#","")
    }   

}

