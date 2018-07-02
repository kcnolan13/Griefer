/// @description challenge auto completion
auto_frame_counter --
if auto_frame_counter < 1
{
    auto_frame_counter = auto_frame_offset
    if in_match() and progress_varname != "" and not match_starting() //reduce frames checked to save performance a bit
    {
        var grav = net_manager.stat_gravatar
        if instance_exists(grav) and instance_exists(myAvatar()) and playerName(grav) != playerName(myAvatar())
        {
            printf(":::WARNING: cannot complete challenge while looking at another player ("+playerName(grav)+")'s stats")
        }
        else //yes you can complete this challenge!
        {
            if is_competitive
                progress = acc_data(progress_varname,COL_TOTAL)
            else if is_bot_mode {
                if bot_diff_ind > 2
                    progress = acc_data(progress_varname,COL_BOT4_TOTAL)
                else if bot_diff_ind > 1
                    progress = acc_data(progress_varname,COL_BOT3_TOTAL)
                else if bot_diff_ind > 0
                    progress = acc_data(progress_varname,COL_BOT2_TOTAL)
                else
                    progress = acc_data(progress_varname,COL_BOT_TOTAL)
            }
            else if is_challenge
                progress = acc_data(progress_varname,COL_TOTAL) + acc_data(progress_varname,COL_BOT_TOTAL) + acc_data(progress_varname,COL_BOT2_TOTAL) + acc_data(progress_varname,COL_BOT3_TOTAL) + acc_data(progress_varname,COL_BOT4_TOTAL)
            
            progress_max = acc_needed //acc_data(progress_varname,COL_CHAL_NEEDED)
            
            if progress > progress_max or completed
                progress = progress_max
                
            if progress >= progress_max and not completed and progress_max > 0
            {
                printf("::: auto completing challenge: "+string(name))
                //if abs(rtime() - net_manager.starting_match_delay) < auto_frame_offset*3
                //    completed_quietly = true
                complete_challenge(name)
            }
        }
    }
}

if nth_frame(120) and room = rm_lobby or room = rm_menu and progress_varname != "" and menmode() = "challenges"
{
    var grav = net_manager.stat_gravatar
    if not (instance_exists(grav) and instance_exists(myAvatar()) and playerName(grav) != playerName(myAvatar()))
    {
        if is_competitive
            progress = acc_data(progress_varname,COL_TOTAL)
        else if is_bot_mode {
				if bot_diff_ind > 2
					progress = acc_data(progress_varname,COL_BOT4_TOTAL)
				else if bot_diff_ind > 1
					progress = acc_data(progress_varname,COL_BOT3_TOTAL)
				else if bot_diff_ind > 0
					progress = acc_data(progress_varname,COL_BOT2_TOTAL)
				else
					progress = acc_data(progress_varname,COL_BOT_TOTAL)
			}
        else if is_challenge
            progress = acc_data(progress_varname,COL_TOTAL) + acc_data(progress_varname,COL_BOT_TOTAL) + acc_data(progress_varname,COL_BOT2_TOTAL) + acc_data(progress_varname,COL_BOT3_TOTAL) + acc_data(progress_varname,COL_BOT4_TOTAL)
        
        progress_max = acc_needed //acc_data(progress_varname,COL_CHAL_NEEDED)
        
        if progress > progress_max or completed
            progress = progress_max   
    }
}

///show it when you complete a challenge
if global.using_gamepad 
{
    if gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check_pressed(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_press)
    }
}

if completed
{
    icon = icon_complete
    color = color_complete
}
else
{
    //icon = icon_complete
    //color = color_complete
    icon = icon_complete
    color = color_complete
}

if in_match() and completed and not completed_quietly and (not shown_completed or (not tripped_end_match and objVarRead(net_manager,"end_match_coming")))
{
    printf(":::SHOW POPUP TRIGGERED FOR: "+name)
    if objVarRead(net_manager,"end_match_coming")
        tripped_end_match = true
        
    popup_show = true
    popup_alpha = 0.1//popup_alpha_idle
    popup_alpha_target = popup_alpha_highlighted
    sweep_counter = sweep_delay
    popup_hsp = 0//5
	popup_xoff_extra = -24
    popup_xoff = 0
    popup_yoff = popup_yoff_original
    shown_completed = true
}

if in_match() and popup_show
{
    x = WVIEW-(global.challenge_popup_width)*scl+popup_xoff+popup_xoff_extra
    y = HVIEW-(global.challenge_popup_height)*scl+popup_yoff+popup_yoff_extra
    
    show_number = 0
    
    for (var i=0; i<instance_number(challenge_generic); i++)
    {
        CHA = instance_find(challenge_generic,i)
        if CHA.popup_show and not CHA.completed_quietly
        {
            if CHA.id != id
                show_number ++
            else
                break
        }
    }
    
    popup_yoff = popup_yoff_original-72*show_number
    
    if sweep_counter
    {
        sweep_counter = sub_real(sweep_counter,1)
    }
 
    if not sweep_counter and not match_ending()
    {
        popup_alpha_target = 0
        
        popup_xoff_extra += popup_hsp
        popup_yoff_extra += popup_vsp
        
        if popup_alpha < 0.1
        {
            popup_show = false
            popup_xoff = 0
            popup_yoff = popup_yoff_original
            popup_hsp = 0
            popup_alpha = popup_alpha_idle
        }
    }
}

if popup_show
{
    popup_alpha = lerp_real(popup_alpha, popup_alpha_target, popup_alpha_lerp_real)
    
    if popup_alpha < 0.05
        popup_show = false
}

if txt_show
{
    txt_alpha = lerp_real(txt_alpha,txt_alpha_target,txt_alpha_lerp_real)
    txt_scale = lerp_real(txt_scale,txt_scale_target,txt_scale_lerp_real)
    
    if txt_alpha < 0.05
        txt_show = false
}
else
{
    txt_scale = txt_scale_idle
    txt_alpha = txt_alpha_idle
}

if hovering
{
    cursor_highlight()
    txt_alpha_target = txt_alpha_highlighted
    txt_scale_target = txt_scale_highlighted
    hover_counter += real_speed(1)
} else if hover_counter > 0
{
    hover_counter = sub_real(hover_counter,1)
    txt_alpha_target = txt_alpha_idle
    txt_scale_target = txt_scale_idle
}

///regen surface when needed
if not surface_exists(surf_slot) and regen_delay < 1
{
    //regen challenge slot surfaces
    alarm[1] = ceil(random_range(5,15))
    regen_delay = 30
    printf("::: calling for a challenge surface regen")
}
else if regen_delay > 0
{
    regen_delay --
}


if xtarget != x
{
	x = lerp_real(x, xtarget, 0.3)
	if abs(x - xtarget) < 0.1
		x = xtarget
}
if ytarget != y
{
	y = lerp_real(y, ytarget, 0.3)
	if abs(y - ytarget) < 0.1
		y = ytarget
}
if loading_alpha != loading_alpha_target and loading_alpha_lerp_delay < 1 {
	loading_alpha = lerp_real(loading_alpha, loading_alpha_target, loading_alpha_lerp)	
}

if loading_alpha_lerp_delay > 0 {
	loading_alpha_lerp_delay --
}

if not in_match() and menmode() == "challenges" {
	if cursor.x >= x and cursor.y >= y and cursor.x <= bbox_right and cursor.y <= bbox_bottom
            //and not challenge_manager.challenge_showing_popup
        {
            hovering = true
        }
        else
        {
            hovering = false
            played_highlight_sound = false
            //hover_counter = 0
        }
        
        if hovering and not played_highlight_sound
        {
            played_highlight_sound = true
            audio(snd_scroll,GAIN_HIGHLIGHT)
        }
        
        if hover_counter > hover_delay and instance_place(x,y,cursor)
        {
            //draw the popup for this challenge
            popup_show = true
            popup_alpha = popup_alpha_highlighted
            popup_alpha_target = popup_alpha
            icon = icon_complete
            
            //done in popup_drawer now
            //draw_popup_challenge(cursor.x, cursor.y, name, "", desc, icon, color_complete, 1,1)
            
            //determine whether to use the surface or not
            
            
            depth = -103
            if new
                new = false
        } else 
        {
            popup_show = false
            popup_alpha = 0
            depth = -96
        }	
}