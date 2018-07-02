/// @description draw popups in game, at end game, txt in menu, and popups in menu
if room = rm_menu or room = rm_lobby
{
    /*draw_set_alpha(1)
    draw_set_color(c_red)
    draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true)*/
    image_xscale =2 
    image_yscale =2
    //printf(net_manager.menu_mode)
    //if net_manager.menu_mode = "challenges"
	if loading_alpha > 0.05
    {
        txt_show = true
        //printf("drawing bpart_slot_complete @ "+x+", "+y)
        var off = (txt_scale*72-72)/2
        
        //if draw_allow = 1
		if icon == spr_longhorn_hat and loading_alpha < 0.9 and loading_alpha > 0.1
			printf("::: drawing longhorn_hat challenge with loading alpha"+string(loading_alpha))
        draw_bpart_slot_complete_ext2(id, x-off, y-off, txt_scale*loading_alpha, txt_alpha*loading_alpha)
		//draw_bpart_slot_complete_ext(id, x, y, 1, 1)
            
        if new
        {
            draw_notification(1,x-off+global.noffset*txt_scale,y-off+global.noffset*txt_scale,txt_scale,color_complete,loading_alpha)
        }
        
        //done in popup_drawer now
        //draw_mod_notification(x+72-global.moffset,y+global.moffset,icon)
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
        popup_xoff_extra = -30
    }
    
    var dy = y+(popup_yoff+popup_yoff_extra)*scl
    if dy < 64 dy = 64
    if dy > HVIEW-64 dy = HVIEW-64
    draw_popup_challenge(x+(popup_xoff+popup_xoff_extra+endmatch_offset)*(1+(1-scl)), dy, name, "", descr, icon, color, popup_alpha,scl)
    //printf("::: show_number = "+string(show_number)+", id="+string(id)+", popup_xoff="+string(popup_xoff)+", popup_xoff_extra="+string(popup_xoff_extra))
}

/* */
/*  */
