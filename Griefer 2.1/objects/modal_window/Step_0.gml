/// @description all dat ish
counter ++

if snapped = false
{
    modal_recalculate_snap()
}

if fade_delay
{
    fade_delay = sub_real(fade_delay,1)
    if not fade_delay
    {
        fade_out = true
    }
}

if birth_delay > 0
{
    birth_delay = sub_real(birth_delay,1)
    
    if wait_while_loading and waiting_for_data()
    {
        birth_delay = post_loading_wait_time
    }

    
    if fade_out
        instance_destroy()
    
    exit
}

if menu_mode != "all" and menmode() != menu_mode
{
    fade_out = true
}

//TRANSLATION
if translation_x != translation_xtarget or translation_y != translation_ytarget
{
    x += lerp(translation_x, translation_xtarget, translation_lerp) - translation_x
    y += lerp(translation_y, translation_ytarget, translation_lerp) - translation_y
    
    translation_x = lerp(translation_x, translation_xtarget, translation_lerp)
    translation_y = lerp(translation_y, translation_ytarget, translation_lerp)
    
    modal_recalculate_snap()
    
    if abs(translation_y - translation_ytarget) < 0.5
        translation_y = translation_ytarget
        
    if abs(translation_x - translation_xtarget) < 0.5
        translation_x = translation_xtarget
        
    if bind_global_xoff_to_translation_x
    {
        global.xoff = translation_x/2
    }
}

if not is_gui
{
    if snapped and snap_by_percent
    {
        x = __view_get( e__VW.XView, 0 )+view_xpercent*__view_get( e__VW.WView, 0 )
        y = __view_get( e__VW.YView, 0 )+view_ypercent*__view_get( e__VW.HView, 0 )
        if bind_to_global_xoff
            x += global.xoff
    }
    else if snapped
    {
        x = __view_get( e__VW.XView, 0 )+view_xoff
        y = __view_get( e__VW.YView, 0 )+view_yoff
        if bind_to_global_xoff
            x += global.xoff
    } 
}  

image_xscale = width
image_yscale = height

if popped_in
{
    if input_check(mapped_control(C_SHOOT))
    {
        if (not modal_highlighted(id) and die_click_outside) or (die_click_anywhere)
        {
            fade_out = true
        }
    }
}

if not popped_in and abs(scale - scale_normal) <= 0.05 
{
   popped_in = true
   if pop_sound != snd_none
    play_sound_when_ready = true
}

if play_sound_when_ready
{
    do_play_sound = true
    with modal_window
    {
        if pop_sound != snd_none and audio_is_playing(pop_sound)
            other.do_play_sound = false
    }
    if do_play_sound
    {
        play_sound_when_ready = false
        audio(pop_sound,pop_gain/GAIN_AUDIO)
    }
}

if fade_out = true and popped_in and translation_x = translation_xtarget and translation_y = translation_ytarget
{
    alpha -= real_speed(dec)
    
    if alpha < 1
    {
        scale = lerp_real(scale,scale_die,scale_lerp_real)
    }
    if alpha < 0.05
        instance_destroy()
} else
{
}

if modal_highlighted(id)
{
    hover_counter += real_speed(1)
    
    if hover_counter > hover_delay
        show_popup = true
        
    if hover_counter > hover_delay/6 and highlight_sound != snd_none and not highlight_sound_played
    {
        highlight_sound_played = true
        audio(highlight_sound,highlight_gain)
    }
        
    scale = lerp_real(scale,scale_highlighted,scale_lerp_real)
    cursor_highlight()
    
    if not fade_out
    {
        alpha = lerp_real(alpha,alpha_highlight,scale_lerp_real)
    }
}
else
{
    highlight_sound_played = false
    hover_counter = 0
    show_popup = false
    scale = lerp_real(scale,scale_normal,scale_lerp_real)
    if not fade_out
    {
        if not active
            alpha = lerp_real(alpha,alpha_max,scale_lerp_real)
        else
            alpha = lerp_real(alpha,alpha_highlight,scale_lerp_real)
    }
}

///tips
if is_tips
{
    tip_counter += real_speed(1)
    if tip_counter > tip_timeout
    {
        tip_counter = 0
        tip_index++
        
        if tip_index >= getLength(net_manager.pre)
            tip_index = 0
        if tip_index < 0
            tip_index = 0
            
        text = tip_text(tip_index)
    }
    /*if nth_frame(5)
    {
        printf("::: text = "+string(text)+", text_yoff = "+string(text_yoff))
    }*/
}

/* */
/*  */
