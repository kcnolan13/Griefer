/// @description stuff
if not instance_exists(bound_avatar)
{
    printf("::: destroying bn_ready -- nonexistent bound_avatar")
    instance_destroy()
    exit
}

event_inherited()

if nth_frame(30) and instance_exists(bound_avatar)
    obj_update_real(bound_avatar,"ready",FL_NORMAL)

if ready
{ 
    text = ready_text
    active = true
    text_color = text_color_ready
    font = ready_font
    text_yoff = 0
}
else 
{
    font = not_ready_font
    text = not_ready_text
    active = false
    text_color = text_color_not_ready
    text_yoff = 3
}

label = text

if in_match()
{
    visible = false
}
else
{
    if menmode() = "lobby"
    {
        //jump to a decent position below the avatar
        if instance_exists(bn_vote) and abs(bound_avatar.x - objVarRead(bound_avatar,"dude_x") < 10) and abs(bound_avatar.y - objVarRead(bound_avatar,"dude_y") < 10) and bound_avatar.visible and objVarRead(bound_avatar,"visible")
        {
            var somey = 64*2.95*net_manager.av_scale_lobby/2.7
            if instance_number(avatar) < 3
                somey = 64*3.225*net_manager.av_scale_lobby/2.7
                
            visible = true
            x = bound_avatar.x
            y = bound_avatar.y+somey
            modal_aligns()
            depth = bound_avatar.depth - 5
        }
        else
        {
            visible = false
            alpha = 0
            x = -999
            y = -999
        }
        
        if myAvatar() != bound_avatar
        {
            ready = objVarRead(bound_avatar,"ready")
        }
        
        if net_manager.lobby_match_countdown
        {
            objVarWrite(bound_avatar,"ready",ready)
            ready = true
        }
        
        if net_manager.bot_match and nth_frame(30) and not sent_ready
        {
            start_match = true
            with avatar
            {
                if not varRead("ready")
                    other.start_match = false
            }
            
            if start_match
            {
                with bn_ready sent_ready = true
                printf("::: SENDING START MATCH NOW")
                sendMessageReal("everyone_ready",FL_NORMAL)
            }
        }
        
    }
    else
    {
        //hide the ready button
        visible = false
        x = -999
        y = -999
    }
}

