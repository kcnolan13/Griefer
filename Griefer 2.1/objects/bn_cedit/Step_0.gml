/// @description capture input
if not instance_exists(modal_controls)
{
    instance_destroy()
    exit
}

if not modal_highlighted(id) and was_highlighted
{
    was_highlighted--
}

if string_upper(text) = "YES" or string_upper(text) = "NO"
{
    is_yesno = true
    is_onoff = false
    is_sens = false
}

if string_upper(text) = "ON" or string_upper(text) = "OFF"
{
    is_onoff = true
    is_yesno = false
    is_sens = false
}

if not is_sens
{
    if not capturing
        capture_timer = 0
    else
        capture_timer ++

    if capturing and capture_timer > 30/2
    {
        capture_mapping_input()
    }
    
    if instance_exists(myLabel) and not visible
    {
        visible = true
        myLabel.visible = true
    }
    
}
else
{
    xs = drew_left+sp
    xf = drew_right-sp
    
    if instance_exists(modal_controls) and modal_controls.mode_index = 2
    {
        if instance_exists(myLabel) 
        {
            if not global.using_gamepad
            {
                visible = false
                myLabel.visible = false
            } else
            {
                visible = true
                myLabel.visible = true
            }
            
        }
        
        if string(label_name) = global.cactions[C_LOOK_SENS]
        {
            if global.using_gamepad
            {
                sens_low = global.match_cursor_speed_low
                sens_high = global.match_cursor_speed_high
            }
            else
            {
                sens_low = global.nogp_match_cursor_speed_low
                sens_high = global.nogp_match_cursor_speed_high
            }
        }
        else
        {
            if global.using_gamepad
            {
                sens_low = global.cursor_speed_low
                sens_high = global.cursor_speed_high
            }
            else
            {
                sens_low = global.nogp_cursor_speed_low
                sens_high = global.nogp_cursor_speed_high
            }
        }
        
        if recompute_sens_percent
        {
            sens_percent = (sens_val-sens_low)/(sens_high - sens_low)
        }   
        
    }
    
    if instance_exists(modal_controls)
    {
        //is a sensitivity input
        if sens_update
        {
            sens_update --   
            
            if not sens_update
            {
                //update the control values for this field
                if modal_controls.mode_index = 2
                    map_control(label_name,sens_val)
                else
                {
                    var ind = gc_ind(myLabel.text)
                    if ind > -1
                        save_setting(ind)
                    else
                    {
                        printf("ERROR: unable to save setting: "+string(myLabel.text)+" has ind: "+string(ind))
                    }
                }
            }
        }
    }
    
    if sens_val > sens_high
        sens_val = sens_high
    if sens_val < sens_low
        sens_val = sens_low
}

if instance_exists(myLabel) and myLabel.text = global.cactions[C_SWAP_STICKS]
{
    if global.using_gamepad
    {
        if not visible
        {
            scale = 0
            alpha = 0
            popped_in = false
        }  
        visible = true
    }
    else
    {
        visible = false
    }
    if global.cvals[C_SWAP_STICKS]
    {
        text = "True"
        text_normal = "True"
    } else
    {
        text = "False"
        text_normal = "False"
    }
}

///all dat ish
event_inherited()
label = text
life++

if life > 1 and not is_onoff and not is_yesno
{
    if not capturing
        text = text_normal
    else
        text = text_capturing
}

