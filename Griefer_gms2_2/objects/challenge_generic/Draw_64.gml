/// @description draw popups in game, at end game, txt in menu, and popups in menu
if room = rm_menu or room = rm_lobby
{
    /*draw_set_alpha(1)
    draw_set_color(c_red)
    draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true)*/
    image_xscale =2 
    image_yscale =2
    //printf(net_manager.menu_mode)
    if net_manager.menu_mode = "challenges"
    {
        txt_show = true
        //printf("drawing bpart_slot_complete @ "+x+", "+y)
        var off = (txt_scale*72-72)/2
        
        //if draw_allow = 1
        draw_bpart_slot_complete_ext(id, x-off, y-off, txt_scale, txt_alpha)
            
        if new
        {
            draw_notification(1,x-off+global.noffset*txt_scale,y-off+global.noffset*txt_scale,txt_scale,color_complete,1)
        }
        
        //done in popup_drawer now
        //draw_mod_notification(x+72-global.moffset,y+global.moffset,icon)
        
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
    else
    {
        txt_show = false
        popup_show = false
    }
}

//BEHAVIOR FOR IN MATCH
if in_match() and popup_show and not is_progression and not completed_quietly
{
    var endmatch_offset = 0
    var descr = description
    if match_ending()
    {
        //endmatch_offset = 64
        //descr = ""
        popup_xoff_extra = 0
    }
    
    var dy = y+(popup_yoff+popup_yoff_extra)*scl
    if dy < 64 dy = 64
    if dy > HVIEW-64 dy = HVIEW-64
    draw_popup_challenge(x+(popup_xoff+popup_xoff_extra+endmatch_offset)*(1+(1-scl)), dy, name, "", descr, icon, color, popup_alpha,scl)
    //printf("::: show_number = "+string(show_number)+", id="+string(id)+", popup_xoff="+string(popup_xoff)+", popup_xoff_extra="+string(popup_xoff_extra))
}

/* */
/*  */
