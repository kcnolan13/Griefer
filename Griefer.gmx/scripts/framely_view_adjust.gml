///framely_view_adjust()

if not is_bot(id) and not double_spawn_counter and  not respawn_counter and (visible and varRead("controllable")) and not net_manager.starting_match//or (net_manager.starting_match and net_manager.local_player = id)
{
    computed_view = true
    
    if instance_exists(varRead("active_weapon"))
    {
        if not objVarRead(varRead("active_weapon"),"quicktoss_backcycles")
        {
            view_hwidth = floor(1365*objVarRead(varRead("active_weapon"),"view_scale")*VIEW_SCALE)
            if view_hwidth > room_width
                view_hwidth = room_width
            
            view_vwidth = floor((9/16)*view_hwidth)
        }
    } else
    {
        view_hwidth = floor(1365*VIEW_SCALE)
        
        if view_hwidth > room_width
                view_hwidth = room_width
        
        view_vwidth = floor((9/16)*view_hwidth)
    }
    
    var cxoff = cursor.x
    var cyoff = cursor.y
    
    //if abs(view_hwidth-view_wview) > 1 and abs(view_vwidth-view_hview) > 1
    if not instance_exists(modal_controls)
    {
        view_wview = ceil(lerp(view_wview,view_hwidth,0.5))
        view_hview = ceil(lerp(view_hview,view_vwidth,0.5))
    }
    else
    {
        view_wview = 1365
        view_hview = 9/16*1365
        cxoff = view_xview+view_wview/2
        cyoff = view_yview+view_hview/2
    }

    view_scaler = 1

    //calculate x offset percentages (percent of view_width away from middle of screen)
    view_xoffset = -1*(view_xview+floor(view_wview/2)-cxoff)/(floor(view_wview/2))
    
        //constrain maximum x offset to 1
        if abs(view_xoffset)>1 
        view_xoffset = sign(view_xoffset)
    
    //calculate y offset percentages (percent of view_width away from middle of screen)    
    view_yoffset = -1*(view_yview+floor(view_hview/2)-cyoff)/(floor(view_hview/2))
    
        //constrain maximum y offset to 1
        if abs(view_yoffset)>1 
        view_yoffset = sign(view_yoffset)
    
    // add up to 1/3 of the view's height/width depending on offset percentages
    xtest = floor(x+16-floor(view_wview/2)+floor(view_xoffset*view_wview*1/3*view_scaler))
    ytest = floor(y+16-floor(view_hview/2)+floor(view_yoffset*view_hview*1/3*view_scaler))
    
    if not global.using_gamepad or not varRead("alive") or net_manager.match_countdown or net_manager.starting_match or abs(xtest-view_xview) > 3 or (gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv))
        view_xview=xtest
    if not global.using_gamepad or not varRead("alive") or net_manager.match_countdown or net_manager.starting_match or abs(ytest-view_yview) > 3 or (gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv))
        view_yview=ytest
    
    //shake the view
    if view_shake_counter > 0 and not instance_exists(modal_controls)
    {
        //printf("::: view shake is "+string(view_shake_counter))
        view_xview += random_range(-4*view_shake_counter,4*view_shake_counter)
        view_yview += random_range(-4*view_shake_counter,4*view_shake_counter)
        view_shake_counter = floor(view_shake_counter / 1.5)
    }
    
    // make sure the adjusted view doesn't go outside the room
    if view_xview < 0 
    view_xview = 0
    
    if view_xview > (room_width-view_wview)
    view_xview = room_width-view_wview
    
    if view_yview<0 
    view_yview = 0
    
    if view_yview > (room_height-view_hview)
    view_yview = room_height-view_hview
    
    
}

//printf("::: cursor_x = "+string(cursor.x)+", cursor_y = "+string(cursor.y)+", x = "+string(x)+", y = "+string(y))
//printf("::: view_wview = "+string(view_wview)+", view_hview = "+string(view_hview))
//printf("::: view_xview = "+string(view_xview)+", view_yview = "+string(view_yview))