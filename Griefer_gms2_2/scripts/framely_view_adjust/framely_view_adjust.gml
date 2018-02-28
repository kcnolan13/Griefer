/// @description framely_view_adjust()
/// @function framely_view_adjust

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
        __view_set( e__VW.WView, 0, ceil(lerp_real(__view_get( e__VW.WView, 0 ),view_hwidth,0.5 )))
        __view_set( e__VW.HView, 0, ceil(lerp_real(__view_get( e__VW.HView, 0 ),view_vwidth,0.5 )))
    }
    else
    {
        __view_set( e__VW.WView, 0, 1365 )
        __view_set( e__VW.HView, 0, 9/16*1365 )
        cxoff = __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2
        cyoff = __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2
    }

    view_scaler = 1

    //calculate x offset percentages (percent of view_width away from middle of screen)
    view_xoffset = -1*(__view_get( e__VW.XView, 0 )+floor(__view_get( e__VW.WView, 0 )/2)-cxoff)/(floor(__view_get( e__VW.WView, 0 )/2))
    
        //constrain maximum x offset to 1
        if abs(view_xoffset)>1 
        view_xoffset = sign(view_xoffset)
    
    //calculate y offset percentages (percent of view_width away from middle of screen)    
    view_yoffset = -1*(__view_get( e__VW.YView, 0 )+floor(__view_get( e__VW.HView, 0 )/2)-cyoff)/(floor(__view_get( e__VW.HView, 0 )/2))
    
        //constrain maximum y offset to 1
        if abs(view_yoffset)>1 
        view_yoffset = sign(view_yoffset)
    
    // add up to 1/3 of the view's height/width depending on offset percentages
    xtest = floor(x+16-floor(__view_get( e__VW.WView, 0 )/2)+floor(view_xoffset*__view_get( e__VW.WView, 0 )*1/3*view_scaler))
    ytest = floor(y+16-floor(__view_get( e__VW.HView, 0 )/2)+floor(view_yoffset*__view_get( e__VW.HView, 0 )*1/3*view_scaler))
    
    if not global.using_gamepad or not varRead("alive") or net_manager.match_countdown or net_manager.starting_match or abs(xtest-__view_get( e__VW.XView, 0 )) > 3 or (gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv))
        __view_set( e__VW.XView, 0, xtest )
    if not global.using_gamepad or not varRead("alive") or net_manager.match_countdown or net_manager.starting_match or abs(ytest-__view_get( e__VW.YView, 0 )) > 3 or (gamepad_axis_check(global.devno,gp_axisrh) or gamepad_axis_check(global.devno,gp_axisrv))
        __view_set( e__VW.YView, 0, ytest )
    
    //shake the view
    if view_shake_counter > 0 and not instance_exists(modal_controls)
    {
        //printf("::: view shake is "+string(view_shake_counter))
        __view_set( e__VW.XView, 0, __view_get( e__VW.XView, 0 ) + (random_range(-4*view_shake_counter,4*view_shake_counter) ))
        __view_set( e__VW.YView, 0, __view_get( e__VW.YView, 0 ) + (random_range(-4*view_shake_counter,4*view_shake_counter) ))
        view_shake_counter = floor(view_shake_counter / 1.5)
    }
    
    // make sure the adjusted view doesn't go outside the room
    if __view_get( e__VW.XView, 0 ) < 0 
    __view_set( e__VW.XView, 0, 0 )
    
    if __view_get( e__VW.XView, 0 ) > (room_width-__view_get( e__VW.WView, 0 ))
    __view_set( e__VW.XView, 0, room_width-__view_get( e__VW.WView, 0 ) )
    
    if __view_get( e__VW.YView, 0 )<0 
    __view_set( e__VW.YView, 0, 0 )
    
    if __view_get( e__VW.YView, 0 ) > (room_height-__view_get( e__VW.HView, 0 ))
    __view_set( e__VW.YView, 0, room_height-__view_get( e__VW.HView, 0 ) )
    
    
}

//printf("::: cursor_x = "+string(cursor.x)+", cursor_y = "+string(cursor.y)+", x = "+string(x)+", y = "+string(y))
//printf("::: view_wview = "+string(view_wview)+", view_hview = "+string(view_hview))
//printf("::: view_xview = "+string(view_xview)+", view_yview = "+string(view_yview))