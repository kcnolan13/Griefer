///manage_voting_modals
if room = rm_lobby 
{
    
    if not match_countdown and is_avatar_leader(myAvatar())
    {
        if time_after_readies >= 0
            time_after_readies++
            
        if time_after_readies > 30*5
        {
            all_avs_ready = true
            with avatar
            {
                if not varRead("ready")
                {
                    other.all_avs_ready = false
                }
            }
            if all_avs_ready
            {
                with avatar
                {
                    varWrite("ready",true)
                    obj_update_real(id,"ready",FL_NORMAL)
                }
                with bn_ready sent_ready = true
                printf("::: WHY ARE WE NOT READY YET? LOBBY LEADER SENDING EVERYONE_READY")
                //sendMessageReal("everyone_ready",FL_NORMAL)
                time_after_readies = -1
            }
        }
    }

    if not lock_armory and not instance_exists(bn_vote) and rtime() > 30*4 and varRead("next_map1") >= 0 and varRead("next_map2") >= 0 and varRead("next_map3") >= 0
    {
        next_map_final = noone
        
        mnums[0] = varRead("next_map1")
        mnums[1] = varRead("next_map2")
        mnums[2] = varRead("next_map3")
        
        var bdelay = 0
        var binc = 10
        var h = 83
        var w = 355
        var vspacer = 10
            
        for (var i=0; i<getLength(mnums); i++)
        {
            ID = instance_create(room_width-w/2-10,92+h/2+i*(h+vspacer),bn_vote)
            ID.map_num = mnums[i]
            ID.birth_delay = bdelay
            bdelay += binc
            
            time_after_readies = 0
            
            //assign images
            ID.image = mapsnap_base+ID.map_num+1
            ID.header_text = string(global.map_names[map_placeholder1+1+ID.map_num])
    
            //the random one
            if i = getLength(mnums)-1
            {
                ID.is_random = true
            }
        }
    }
    else if lock_armory and instance_exists(bn_vote) and varRead("next_map") >= 0
    {
        with bn_vote
        {
            alpha = 0.5
            alpha_max = 0.5
            blocked = true
        }
        if not instance_exists(next_map_final)
        {
            next_map_final = instance_create(room_width/2,210,modal_window)
            with (next_map_final)
            {
                header_text = "Map 1"
                header_text_color = c_white
                header_yoff = -2
                header_font = fnt_hud_biggest
                
                draw_image_gradient = true
                image_gradient_alpha = 0.125
                
                header_color = c_black
                header_alpha = 0.78
                header_height = 48
                
                scale_lerp_real = 0.1
                
                text_yoff = 92
                font = fnt_menu
                
                alpha = 0

                scale = 1
                scale_highlighted = 1.02
                image_stretch = true
                active = true
                highlightable = false
                scale_highlighted = 1.02
                alpha_max = 1
                
                border_width = 4
                border_color = c_white
                border_inscribe = true
                
                is_gui = true
                depth = net_manager.depth-1
                is_random = false
                width = 550+68//bn_vote.width*1.5
                height = 270//bn_vote.height*3
                
                y = 72+20+height/2
                
                width_init = width
                height_init = height
                halign = fa_center
                valign = fa_center
                snap_2view = false
                modal_aligns()
                
                map_num = objVarRead(net_manager,"next_map")
                img_xscale = width/sprite_get_width(snap_double)
                img_yscale = img_xscale
                image = mapsnap_base+map_num+1
                image_crop = true
                header_text = string(global.map_names[map_placeholder1+1+map_num])
                
            }
        }
    }
}
