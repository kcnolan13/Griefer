/// @description add text

if keyboard_check(vk_backspace)
    exit
    
if not popped_in
{
    keyboard_string = ""
    exit
}

if not active and auto_start
{
    auto_start = false
    cursor.x = x
    cursor.y = y
    
    if auto_clear = true
    {
        auto_clear = false
        text = ""
    }

    if string_length(keyboard_string) < max_length
    {
        text = string_replace_all(keyboard_string,"#","")
        audio(snd_keystroke,1)
    } else {
        keyboard_string = string_replace_all(text,"#","")
    }   
    
    event_perform(ev_mouse,ev_global_left_press)
}

if active
{
    if auto_clear = true
    {
        auto_clear = false
        text = ""
    }

    if string_length(keyboard_string) < max_length
    {
        audio(snd_keystroke,1)
        text = keyboard_string
    } else {
        keyboard_string = text
    }   

}

