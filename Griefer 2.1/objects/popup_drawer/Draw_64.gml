/// @description draw a popup sometimes
if draw_it
{
    title_height = global.popup_title_height
    body_height = global.popup_body_height
    width = global.popup_width
    txt_pad = global.popup_txt_pad
    
    alph = alpha

    if draw_x = mouse_x and draw_y = mouse_y and global.using_gamepad
    {
        draw_x = cursor.x
        draw_y = cursor.y
    }
    
    if net_manager.menu_mode = "armory" //or (net_manager.av_popup != noone and y > room_height/2)
    {
        draw_x = cursor.x
        if draw_x < room_width/2
            draw_x -= net_manager.armory_sl
        draw_y = cursor.y
        alph = alpha*0.75
    }
    
    if draw_x+net_manager.armory_sl >= room_width/2
    {
        left = draw_x - width
        right = draw_x
        top = draw_y
        bottom = draw_y+title_height+body_height
    }
    else
    {
        left = draw_x+net_manager.armory_sl
        right = draw_x+width+net_manager.armory_sl
        top = draw_y
        bottom = draw_y+title_height+body_height
    }
    
    var attempts = 0
    while (bottom > room_height and attempts < 1000)
    {
        attempts ++
        bottom --
        top --
    }

    //compute draw positions and shit

    //determine whether to use the surface or not
    var mod_ind = bpart_mod_index(icon_ref)
    if mod_ind > GARBAGE and surface_exists(surf_popup)
    {
        surface_set_target(surf_popup)
        draw_clear_alpha(c_black,0)
        draw_set_color(c_white)
        draw_set_alpha(1)
        draw_sinbad = true
        draw_popup(0, 0, dat_title, subtitle, source, body_text_override, color, alph)
        col = c_white
        if bpart_mod_var(icon_ref) = "blood_color"
        {
            col = bpart_mod_val(icon_ref)
            draw_set_color(c_white)
            //draw some blood to the popup surface.... also draw the fancy text
            draw_splats(global.popup_width-40,40,0.6,col,1)
        }
        
        if bpart_mod_var(icon_ref) = "animated"
        {
            col = bpart_mod_val(icon_ref)
            draw_set_color(c_white)
            //draw some blood to the popup surface.... also draw the fancy text
            draw_icon_animated(global.popup_width-40,40,0.6,col,1)
        }
        
        //draw the fancy text
        surface_reset_target()
        
        draw_set_alpha(1)
        draw_surface(surf_popup,left,top)
        
        var txt = global.mod_descriptions[mod_ind]
        var txt_col = c_white
            if do_fancy_text_black(col)
                txt_col = c_black
        var txt_scale = 1*global.notification_scale
        var txt_rot = -45
        var toff = 32
        draw_set_color(txt_col)
        draw_set_font(fnt_mod)
        draw_set_halign(fa_center)
        draw_set_valign(fa_center)
        draw_text_ext_transformed(right-toff,top+toff,string_hash_to_newline(txt),24,global.popup_width,txt_scale,txt_scale,txt_rot)
        draw_set_font(fnt_hud)
    }
    else
    {
        draw_popup(left, top, dat_title, subtitle, source, body_text_override, color, alph)
    }
    draw_it = false
}

///draw the animated thingy for challenges
if menmode() = "challenges"
{
    if draw_challenge_splash_text
        draw_challenge_splash_text --
        
    mod_ind = GARBAGE
    icon_ref = 0
    top = -10000
    left = -10000
    right = -9000
    
    with challenge_generic
    {
        if room = rm_menu or room = rm_lobby
        {
            if loading_alpha > 0.9 {
                draw_mod_notification(x+72-global.moffset,y+global.moffset,icon)
            }
        }
    }
    
    with challenge_generic
    {
        if hover_counter > hover_delay and instance_place(x,y,cursor)
        {
            var desc = description
            
            if completed
            {
                for (var i=0; i<getLength(rewards); i++)
                {
                    if not bpart_has_armor_lists(rewards[i]) and not bpart_has_cache(rewards[i])
                    {
                        desc = "Click To Redeem!"
                    }
                }
            }
            
            icon = icon_complete
            other.titties = bpart_mod_index(icon)
            //printf(":::set other.mod_ind = "+string(bpart_mod_index(icon)))
            if other.draw_challenge_splash_text < 8
                other.draw_challenge_splash_text += 2
            other.icon_ref = icon
            other.top = top
            other.left = left
            other.right = right
            other.chal_id = id
            
            draw_popup_challenge(cursor.x, cursor.y, name, "", desc, icon, color_complete, 1,1)
        }   
    }
    
    
    //SPLASH TEXT
    if draw_challenge_splash_text > 4
    {
        //printf("::: mod_ind = "+string(titties))
        if titties > GARBAGE and surface_exists(surf_popup) and instance_exists(chal_id)
        {
            top = chal_id.top
            left = chal_id.left
            righ = chal_id.right
            
            surface_set_target(surf_popup)
            draw_clear_alpha(c_black,0)
            draw_set_color(c_white)
            draw_set_alpha(1)
            
            col = c_white
            
            if bpart_mod_var(icon_ref) = "blood_color"
            {
                col = bpart_mod_val(icon_ref)
                draw_set_color(c_white)
                //draw some blood to the popup surface.... also draw the fancy text
                draw_splats(global.popup_width-40,40,0.6,col,1)
            }
            
            if bpart_mod_var(icon_ref) = "animated"
            {
                col = bpart_mod_val(icon_ref)
                draw_set_color(c_white)
                //draw some blood to the popup surface.... also draw the fancy text
                draw_icon_animated(global.popup_width-40,40,0.6,col,1)
            }
            
            //draw the fancy text
            surface_reset_target()
            
            draw_set_alpha(1)
            draw_surface(surf_popup,right-global.popup_width,top)
            
            var t = global.mod_descriptions[titties]
            var tcol = c_white
                if do_fancy_text_black(col)
                    tcol = c_black
            var tscale = 1*global.notification_scale
            var trot = -45
            var toff = 32
            draw_set_color(tcol)
            draw_set_font(fnt_mod)
            draw_set_halign(fa_center)
            draw_set_valign(fa_center)
            draw_text_ext_transformed(right-toff,top+toff,string_hash_to_newline(t),24,global.popup_width,tscale,tscale,trot)
            draw_set_font(fnt_hud)
        }
    }
      
}

