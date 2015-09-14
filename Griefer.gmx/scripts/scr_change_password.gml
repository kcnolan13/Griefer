///scr_change_password()
with bn_input_field
{
    if is_password
    {
        if text = text_default
        {
            popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Invalid Password","You must enter a password.")
            other.pressed_enter = false
            other.fade_out = false
        }
        else if string_length(text) < min_length
        {
            popup_alert(WVIEW/2+global.xoff,HVIEW/2,"Invalid Password","Your password name must be at least "+string(min_length)+" characters")
            other.pressed_enter = false
            other.fade_out = false
        }
        else
        {
            audio(snd_click,1)
            popup_loading(WVIEW/2,HVIEW/2)
            sendMessageStr("change_password",text)
            fade_out = true
            with modal_dialogue
            {
                if is_input_field
                    fade_out = true
            }
        }
    }
}
