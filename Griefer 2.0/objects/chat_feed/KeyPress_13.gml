/// @description send message
if alpha_scaler > 0.1
{
    if string_length(entry.input_string) > 0 and instance_exists(net_manager.my_doll) and entry.input_active
    {
        audio(snd_click,1)
        var name = objVarRead(net_manager.my_doll,"pName")
        new_chat_feed_message(name,"",entry.input_string)
        if not net_manager.bot_match and room != rm_menu
        {
            sendBigMessageStr("chat_feed",name,"",entry.input_string)
        }
        if in_match() and not match_ending() and not match_starting()
        {
            entry.input_active = false
            if truthval(global.gc[GC_CHAT_FEED,1]) != 0
            {
                alpha_scaler = alpha_scaler_max
                alpha_dec_delay = alpha_dec_delay_max
                force_show = false
            }
        }
        entry.str_cursor = ""
        entry.input_string = ""
        keyboard_string = ""
    }
}

