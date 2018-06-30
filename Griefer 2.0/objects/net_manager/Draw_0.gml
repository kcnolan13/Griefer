/// @description login screen
if room = rm_login
{
    draw_set_font(fnt_title)
    draw_set_color(c_white)
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    var ts_lerp_real = 0.5
    var ts_target = 1
    
    var tit_y = 64*1.5
    
    title.x = room_width/2+global.xoff
    title.y = tit_y
    
    /*if instance_place(cursor.x,cursor.y,title)
        ts_target = title_scale_max
    else*/
        ts_target = title_scale_min
        
    title_scale = lerp_real(title_scale,ts_target,ts_lerp_real)
    
    if abs(title_scale - ts_target) < 0.05
        title_scale = ts_target
        
    draw_text_ext_transformed(room_width/2+global.xoff,tit_y,string_hash_to_newline("GRIEFER"),32,room_width/2,title_scale,title_scale,0)

    if not instance_exists(modal_splat) and not login_when_ready
    {
        //create the splats
        random_set_seed(random_seed)
        var total_splats = 12
        var splats = 0
        var splats_per_step = 1
        var bdelay = 6
        var binc = 4
        var xextra = 64*3
        var yextra = 0
        var l = title.x-sprite_get_width(spr_title)/2-xextra-global.xoff
        var r = title.x+sprite_get_width(spr_title)/2+xextra-global.xoff
        var t = title.y-sprite_get_height(spr_title)/2-yextra
        var b = title.y+sprite_get_height(spr_title)/2+yextra
        
        while (splats < total_splats)
        {
            repeat (splats_per_step)
            {
                splats++
                
                splat = instance_create(random_range(l,r),random_range(t,b),modal_splat)
                splat.bind_to_global_xoff = true

                //if rtime() > 30*5
                //    bdelay = 0

                splat.birth_delay = bdelay
                splat.depth = 1
                splat.scale_born = 0
                splat.scale_lerp_real = 0.1
            }
            bdelay += binc
        }
        
        //RANDOMIZE THE GAME!
        randomize()
        random_set_seed(random(1000000))
    }
}

/* */
///menu and lobby

barh = 22

//menu-type room commonalities
if room = rm_menu or room = rm_lobby
{
    
    //draw bottom status bar
    draw_set_alpha(1)
    draw_rectangle_colour(0,HVIEW-barh-draw_edge_padding,WVIEW,HVIEW-draw_edge_padding,c_dkgray,c_dkgray,c_black,c_black,false)
    draw_set_alpha(1)
    
    if varRead("game_mode") = "no_mode"
    {
        global.bg_color = c_white
    } else if room = rm_lobby
    {
        draw_set_font(fnt_hud)
        draw_set_color(c_white)
        draw_set_halign(fa_left)
        draw_set_valign(fa_middle)
        draw_text(draw_edge_txtpad,room_height-draw_edge_padding-barh/2,string_hash_to_newline(game_mode_name_long(varRead("game_mode"))))
        draw_set_halign(fa_center)
    }
     /*   
    draw_set_color(make_color_rgb(60,60,60))
    draw_rectangle(0,0,room_width,64,false)
    draw_set_color(make_color_rgb(110,110,110))
    draw_rectangle(0,56,room_width,64,false)*/
    
    draw_set_font(fnt_hud)
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_set_color(c_white)
    
    if room = rm_lobby and room_counter > 30*3
    {
        draw_set_halign(fa_right)
        draw_set_valign(fa_middle)
        draw_text(room_width-draw_edge_txtpad,room_height-draw_edge_padding/2-barh/2,string_hash_to_newline("Intermission     "+string(time_30steps_2countdown(varRead("lobby_wait_time")))))
    }
    
    if room = rm_menu and room_counter > 30*2 and menmode() != "armory" and menmode() != "stats"
    {
        draw_set_halign(fa_left)
        draw_set_valign(fa_middle)
        var ptxt = "Players Online"
        var pnums = varRead("players_online")
        if pnums = 1
            ptxt = "Player Online"
        draw_text(draw_edge_txtpad,room_height-draw_edge_padding-barh/2,string_hash_to_newline(string(pnums)+" "+string(ptxt)))
    }
    
}

//searching for match
if room = rm_menu and varRead("game_mode") != "no_mode"
{
    searching_msg = "Finding "
    draw_set_font(fnt_hud)
    draw_set_color(c_white)
    draw_set_halign(fa_right)
    draw_set_valign(fa_middle)
    
    searching_msg += string(game_mode_name_long(varRead("game_mode")))+" . . ."
    draw_text(room_width-draw_edge_txtpad,room_height-draw_edge_padding-barh/2,string_hash_to_newline(searching_msg))
    
    var badd = 35
    var cadd = 20
    
    global.bg_color = real(varRead(varRead("game_mode")+"_color"))    
}

if room = rm_menu or room = rm_lobby
{
    //no armor check
    var no_armor = true
    for (var i=0; i<9; i++)
    {
        var handle = armory_lists[| i]
        var check = handle[| 0]
        if not is_undefined(check) and instance_exists(check)
        {
            if ds_list_size(handle) > 1 or not check.disabled //will be one for the empty slot
                no_armor = false
        }
    }
    
    armor_msg = ""
    if saving_armor
    {
        armor_msg = "Saving Armor . . ."
        with bn_randomize
        {
            birth_delay = 5
            alpha = 0
        }
    } else if no_armor and menu_mode = "armory"
    {
        armor_msg = "You Have No Armor"
        with bn_randomize
        {
            birth_delay = 5
            alpha = 0
        }
    }
    
    //draw armor_msg
    draw_set_font(fnt_hud)
    draw_set_color(c_white)
    draw_set_halign(fa_right)
    draw_set_valign(fa_middle)
    draw_text(room_width-draw_edge_txtpad-string_width(string_hash_to_newline(armor_msg))-32,room_height-draw_edge_padding-barh/2,string_hash_to_newline(armor_msg))
}

/* */
///armory
if (room = rm_menu or room = rm_lobby) and string(menu_mode) = "armory" and instance_exists(my_doll)
{ 
    grid_drawn = false
    drawing_grid_dir = 0
    if abs(my_doll.x - dude_x) < 5 and abs(my_doll.y - dude_y) < 5 
    {
        cache_center = room_width/2-armory_sl/2
        draw_armory_cache(global.cache,cache_center,cache_length,armor_ysep,1)
    
        //draw the first thing in each slot
        slotx = my_doll.x-armory_xoff-armory_sl
        sloty = my_doll.y - armory_yoff
        
        for (var i=0; i<NUM_LIMBS; i++)
        {
            handle = armory_lists[| i]
            first_bpart = handle[| 0]
            bpart_ysync = armory_lists[| 0]
            bpart_ysync = bpart_ysync[| 0]
            
            if not instance_exists(first_bpart) or not instance_exists(bpart_ysync)
            {
                printf("ERROR: NO FIRST ARMORY BPART")
                return false
            }
            first_bpart.x = slotx
            first_bpart.y = sloty
            
            if first_bpart.disabled
                armory_disabled[i] = true
            else
                armory_disabled[i] = false
            
            /*if i = 4
            {
                printf("hat info in first slot: ")
                printf("exists? "+instance_exists(first_bpart))
                printf("obj index? "+first_bpart.object_index)
                printf(first_bpart.x+", "+first_bpart.y+", icon="+first_bpart.icon+", dis="+first_bpart.disabled)
            }*/
            
            draw_set_alpha(1)
            draw_bpart_slot_complete(first_bpart, first_bpart.x, first_bpart.y, 1)
            draw_mod_notification(first_bpart.x+64-global.moffset,first_bpart.y+global.moffset,first_bpart.icon)
            with first_bpart
            {
                if instance_place(x,y,cursor) and not other.id.grid_drawn
                {
                    hovering ++
                    cursor_highlight()
                    if hovering > hover_delay
                    {
                        popup_alpha = lerp_real(popup_alpha,1,popup_lerp_real)
                        if other.id.armory_disabled[i] = false
                            draw_popup_with_drawer(x,y,name,string(global.name_rarity[rarity])+" "+lookup_limb_type_name(limb_type),source,compute_body_text_override(id),color,1,icon)
                        else with other.id
                        {
                            if ds_list_size(handle) > 1
                            {
                                //printf("ds list size is: "+ds_list_size(handle))
                                with first_bpart
                                    draw_popup_with_drawer(x,y,"Right-Click to Enable","","","",c_dkgray,1,icon)
                            }
                        }
                    }
                        
                    if rightclick_pressed() or click_pressed() and not popup_exists() 
                    {
                    
                        //if not audio_is_playing(snd_pickup2)
                                audio(snd_pickup2,1)
                    
                        with other.id
                        {
                            //disable this slot
                            armory_disabled[i] ^= 1
                            
                            if armory_disabled[i]
                            {
                                //send this item to the back of the list and make the first a new "disabled" body part
                                if ds_list_size(handle) < NUM_BPARTS //and ds_list_size(handle) > 1
                                {
                                    ID = instantiate_bpart(spr_helmet_none+i,global.src_disabled,handle)  //8+i is known to be the sprite_index for the spr_none that applies to this limb type
                                    ID.disabled = true
                                    handle[| ds_list_size(handle)-1] = first_bpart
                                    handle[| 0] = ID
                                } else if WARNINGS printf("WARNING: could not disable: no kick-back space")
                            } else {
                                if ds_list_size(handle) > 1
                                {
                                //copy in the last item back to the front (overwriting the "disabled" body part)
                                handle[| 0] = handle[| ds_list_size(handle)-1]
                                ds_list_delete(handle,ds_list_size(handle)-1)
                                } else if WARNINGS printf("WARNING: could not enable: nothing to enable")
                            }
                            
                            sync_my_doll()
                        }
                    }
                    
                    with other.id
                    {
                        //should draw
                        if not armory_alphas[i] = 1
                            audio(snd_scroll,1)
                            
                        armory_alphas[i] = 1//lerp_real(armory_alphas[i],1,0.25)
                        //compute grid coordinates
                        if first_bpart.x < my_doll.x
                        {
                            grid_right = first_bpart.x
                            grid_top = bpart_ysync.y
                            grid_left = 0//first_bpart.x-4*armory_sl-4*armory_ysep
                            grid_bottom = grid_top+6*(armory_sl+armory_ysep)
                        } else {
                            grid_left = first_bpart.x+armory_sl
                            grid_top = bpart_ysync.y
                            grid_right = room_width//grid_left+4*armory_sl+4*armory_ysep
                            grid_bottom = grid_top+6*(armory_sl+armory_ysep)
                        }
                        
                        if i=8
                        {
                            grid_left = 0//first_bpart.x-5*(armory_sl+armory_ysep)
                            grid_right = room_width//first_bpart.x+6*(armory_sl+armory_ysep)
                            grid_top = first_bpart.y
                            grid_bottom = first_bpart.y+(armory_sl+armory_ysep)
                        }
                        
                    }
                }
                else
                {
                    with other.id
                    {
                        //should fade
                        tol = 5
                        if cursor.x < grid_left-tol or cursor.x > grid_right+tol or cursor.y < grid_top-tol or cursor.y > grid_bottom+tol
                        armory_alphas[i] = 0//lerp_real(armory_alphas[i],0,0.25)
                    }
                }
            }
            
            //GRID LABEL DRAWING AND STUFF
            if grid_lalphs[i] < 1 and instance_exists(myAvatar()) 
                                  and abs(myAvatar().y - objVarRead(myAvatar(),"dude_y")) < 0.5
                                  and abs(myAvatar().x - objVarRead(myAvatar(),"dude_x")) < 0.5
                grid_lalphs[i] += lerp(grid_lalph_inc/max(i,1),grid_lalph_inc,0.5)
                
            if grid_lalphs[i] > 1
                grid_lalphs[i] = 1
            
            var grid_lsize = ds_list_size(handle)
            /*for (var bp=0; bp<ds_list_size(handle); bp++)
            {
                var inst = handle[| bp]
                if instance_exists(handle) and inst.object_index = bpart_generic and not inst.disabled
                {
                    grid_lsize++
                }
            }*/
            if grid_lsize < 2
            {
                grid_lalphs[i] = -2*grid_lalph_inc
            }
            else
            {
                var off = 0.75*armory_sl
                var yoff = armory_sl/2
                var xoff = -1*off
                
                if first_bpart.x > my_doll.x
                    xoff = armory_sl+off
                    
                draw_set_alpha(grid_lalphs[i])
                draw_prank_centered = true
                draw_player_rank("+"+string(grid_lsize-1),first_bpart.x+xoff,first_bpart.y+yoff,1.15*abs(lerp(grid_lalphs[i],1,0.2)))
                draw_set_alpha(1)
            }   
            
            if armory_alphas[i] > 0.05
            {
                grid_drawn = true
                draw_set_font(fnt_hud_biggest)
                draw_set_halign(fa_center)
                draw_set_valign(fa_center)
                draw_set_color(c_white)
                
                yoff = -14
                
                if first_bpart.x > my_doll.x
                {
                    xoff = armory_sl*2.5+2*armory_ysep
                    drawing_grid_dir = 1
                    for (var g=4; g<8; g++)
                    {
                        grid_lalphs[g] = -2*grid_lalph_inc
                    }
                }
                else if i != 8
                {
                    xoff = -1*(armory_sl*1.5+2*armory_ysep)
                    drawing_grid_dir = -1
                    for (var g=0; g<4; g++)
                    {
                        grid_lalphs[g] = -2*grid_lalph_inc
                    }
                }
                else if i = 8
                {
                    drawing_grid_dir = 2
                    grid_lalphs[8] = -2*grid_lalph_inc
                }
                
                if drawing_grid_dir = 1
                {
                    with bn_randomize
                    {
                        alpha = 0
                        birth_delay = 5
                    }
                }
                    
                if i=8
                {
                    yoff = -32
                    xoff = armory_sl/2
                    draw_set_color(c_black)
                }
                  
                draw_set_alpha(1)
                draw_text(first_bpart.x+xoff,grid_top+yoff,string_hash_to_newline(lookup_limb_type_name(first_bpart.limb_type)))
                draw_set_color(c_white)
                
                if show_grid != armory_lists[| i]
                {
                    show_grid_counter = 0
                    show_grid = armory_lists[| i]
                }
                
                if (i<NUM_LIMBS-1)
                {
                    draw_armory_grid(armory_lists[| i],first_bpart.x,bpart_ysync.y,armory_sl, armory_ysep, armory_alphas[i])
                }
                else
                {
                    draw_prop_grid(armory_lists[| i], first_bpart.x, first_bpart.y, armory_sl, armory_ysep, armory_alphas[i])
                }
            }
            
            sloty += armory_sl+armory_ysep
            if (i=3)
            {
                slotx = my_doll.x+armory_xoff
                sloty = my_doll.y - armory_yoff
            }
            
            if (i=7)
            {
                slotx = my_doll.x+props_xoff
                sloty = my_doll.y+props_yoff
            }
            
        }
    }    
}
else if not in_match()
{
    for (var i=0; i<NUM_LIMBS; i++)
    {
        grid_lalphs[i] = 0
    }
}

/* */
///draw lottery/steal
if lotto_counter > lotto_delay and instance_exists(xp_bar.aw)
{
    if string(menu_mode) = "lottery_steal" and room = rm_lobby and xp_bar.aw.popped_in
    {
        steal_y = 96
        lottery_x = xp_bar.lottery_x
        lottery_y = xp_bar.lottery_y
        spr_attempts_max = 12
        
        draw_set_font(fnt_hud_big)
        draw_set_color(c_white)
        draw_set_halign(fa_center)
        draw_set_valign(fa_center)
        
        draw_text(lottery_x,lottery_y-24,string_hash_to_newline("Armor Lottery"))
        
        //draw the lottery when it is time
        if mode_counter < mode_total-steal_time
        {
    
            //draw each individual slot --> randomize, but then decide for each one as it becomes time
            lotto_slot_index = 0
            for (lotto_slot_index=0; lotto_slot_index<3; lotto_slot_index++)
            {
                dat_spr_do = spr_none
                spr_attempts = 0
                while (dat_spr_do = spr_none and spr_attempts < spr_attempts_max)
                {
                    //grab a random lotto-based sprite (not challenge based)
                    lotto_index = floor(random_range(spr_armor_placeholder1+1, spr_armor_placeholder2-0.1))
                    if string(bpart_lookup(lotto_index,global.BPART_SOURCE)) = global.src_lotto
                    {
                        dat_spr_do = lotto_index
                        break
                    }
                }
                
                slot_xoff = lottery_x-armory_sl*lotto_slot_scale[lotto_slot_index]/2
                var spacer = armory_ysep*4
                slot_yoff = lottery_y+64*4-(armory_sl*lotto_slot_scale[lotto_slot_index]/2)-spacer-(armory_sl*lotto_slot_scale[lotto_slot_index])+lotto_slot_index*(armory_sl*lotto_slot_scale[lotto_slot_index]+spacer)
            
                if mode_counter > lottery_time-lottery_calc_time-lotto_slot_index*lotto_comein_offset
                {
                    //draw the slot in progress
                    lotto_slot_scale[lotto_slot_index] = lerp_real(lotto_slot_scale[lotto_slot_index],slot_scale_deciding,slot_lerp_real)
                    draw_lotsteal_slot_thinking(slot_xoff,slot_yoff,lotto_slot_scale[lotto_slot_index],1,dat_spr_do)
                    if not audio_is_playing(snd_scroll3)
                        audio(snd_scroll3,1)
                }
                else
                {
                    if mode_counter <= lottery_time-lottery_calc_time-lotto_slot_index*lotto_comein_offset and not sounded_lotto_slot[lotto_slot_index]
                    {
                        sounded_lotto_slot[lotto_slot_index] = true
                        if not instance_exists(bpart_lotto[lotto_slot_index])
                            audio(snd_item_blah,1)
                        else
                            audio(snd_item_new,1)
                    }
                    lotto_slot_scale[lotto_slot_index] = lerp_real(lotto_slot_scale[lotto_slot_index],slot_scale_decided,slot_lerp_real)
                    //draw the finalized slot
                    if not instance_exists(bpart_lotto[lotto_slot_index])
                    {
                        draw_bpart_slot_disabled_ext(slot_xoff, slot_yoff, lotto_slot_scale[lotto_slot_index], 1)
                    } else
                    {
                        //we're good --> draw the finalized slot
                        bpart_lotto[lotto_slot_index].x = slot_xoff
                        bpart_lotto[lotto_slot_index].y = slot_yoff
                        draw_bpart_slot_complete_ext(bpart_lotto[lotto_slot_index],slot_xoff,slot_yoff,lotto_slot_scale[lotto_slot_index],1)
                    }
                }
            }
        }
    }
}

/* */
///spawn controls
if menu_mode = "settings" and not in_match() and not instance_exists(modal_controls)
{
    spawn_controls()
    //draw_sprite_ext(spr_controls,-1,room_width/2,room_height/2,0.75,0.75,0,c_white,1)
}

/* */
///compute/show connection
if show_connection
{
    //compute connection
    var sent_this_frame = 0
    while (packets_sent < packets_to_send and sent_this_frame < packets_per_frame)
    {
        transmissions++
        sendMessageReal("ping",packets_sent)
        sent_this_frame ++
        packets_sent ++
    }
    
    if packets_received < packets_to_send
    {
        frames_elapsed ++
    } else 
    {
        test_complete_counter ++
        if truncate(packets_received/frames_elapsed,2) < packets_per_frame and packets_per_frame > 10 and test_complete_counter > intertest_delay
        {
            packets_per_frame -= lossless_resolution
            packets_sent = 0
            packets_received = 0
            frames_elapsed = 0
            test_complete_counter = 0
        }
    }
    
    draw_set_color(c_black)
    draw_set_alpha(1)
    draw_set_font(fnt_hud)
    draw_set_halign(fa_left)
    var vsep = 20
    var xoff = cursor.x+42
    var yoff = cursor.y+48+vsep*2
    /*draw_text(xoff,yoff+vsep*-1,"-----------------------------")
    draw_text(xoff,yoff,"Connection Test")
    draw_text(xoff,yoff+vsep*1,"-----------------------------")
    draw_text(xoff,yoff+vsep*2,"Packets Sent: "+packets_sent)
    draw_text(xoff,yoff+vsep*3,"Packets Received: "+packets_received)
    draw_text(xoff,yoff+vsep*4,"Frames Elapsed: "+frames_elapsed)
    draw_text(xoff,yoff+vsep*5,"Transmitted Per Frame: "+packets_per_frame)
    draw_text(xoff,yoff+vsep*6,"Received Per Frame: "+truncate(packets_received/frames_elapsed,2))*/
}

/* */
///compute/show trans rate
if show_trans_rate
{
    trans_frames++
    if trans_frames > trans_period
    {
        trans_rate = truncate(transmissions/trans_period,2)
        trans_frames = 0
        transmissions = 0
        
        rec_rate = truncate(receptions/trans_period,2)
        receptions = 0
    }
    
    draw_set_color(c_black)
    draw_set_alpha(1)
    draw_set_font(fnt_hud)
    draw_set_halign(fa_left)
    var vsep = 20
    var xoff = cursor.x+42
    var yoff = cursor.y-64
    draw_text(xoff,yoff+vsep*-2,string_hash_to_newline("FPS: "+fps))
    draw_text(xoff,yoff+vsep*-1,string_hash_to_newline("-----------------------------"))
    draw_text(xoff,yoff,string_hash_to_newline("Netdata Statistics"))
    draw_text(xoff,yoff+vsep*1,string_hash_to_newline("-----------------------------"))
    draw_text(xoff,yoff+vsep*2,string_hash_to_newline("Transmission Rate: "+trans_rate+" ppf"))
    draw_text(xoff,yoff+vsep*3,string_hash_to_newline("Reception Rate: "+rec_rate+" ppf"))
}

/* */
///show cout if desired
if show_cout
{
    draw_set_alpha(0.55)
    draw_set_font(fnt_cout)
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
    draw_set_color(c_dkgray)
    draw_rectangle(0,0,room_width/2,room_height,false)
    draw_set_color(c_white)
    draw_set_alpha(1)
    draw_text_ext(20,10,string_hash_to_newline(cout_str),14,room_width/2-35)
    draw_set_alpha(1)
}

/* */
///draw color picker

if global.map_editor and in_match()
{
    var wscaler = 3
    var w = sprite_get_width(spr_color_picker)*wscaler
    var l = __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )-w/2-10
    var r = l+w
    var t = __view_get( e__VW.YView, 0 )+10
    var h = sprite_get_height(spr_color_picker)
    var b = t+h
    
    var xoff = 32
    
    var mousex = (cursor.x-__view_get( e__VW.XView, 0 ))/__view_get( e__VW.WView, 0 )*WVIEW             //mouse_x-view_xview//display_mouse_get_x()
    var mousey = (cursor.y-__view_get( e__VW.YView, 0 ))/__view_get( e__VW.HView, 0 )*HVIEW             //mouse_y-view_yview//display_mouse_get_y()
    
    //printf("::: color picker mouse coords:    "+string(mousex)+" ,  "+string(mousey))
    
    //primary color picker
    draw_sprite_ext(spr_color_picker,-1,l+10+w/2,t,wscaler,1,0,c_white,1)
    //shade of primary color
    draw_rectangle_colour(l-h-xoff,t,l-xoff,b,c_white,global.color_primary,c_black,c_black,false)
    //selected picked color
    draw_rectangle_colour(l-h-xoff,b+16,l-xoff,b+52,global.color_picker,global.color_picker,global.color_picker,global.color_picker,false)
    
    if mouse_check_button(mb_left)
    { 
        if cursor.x >= l and cursor.x <= r and cursor.y >= t and cursor.y <= b
        {
            global.color_primary = draw_getpixel(mousex,mousey)
            
            var hue_new = colour_get_hue(global.color_primary)
            
            var hue, sat, val 
            hue = colour_get_hue(global.color_picker)
            sat = colour_get_saturation(global.color_picker)
            val = colour_get_value(global.color_picker)
            global.color_picker = make_colour_hsv(hue_new,sat,val)
        }
        
        if cursor.x >= l-h-xoff and cursor.x <= l-xoff and cursor.y >= t and cursor.y <= b
            global.color_picker = draw_getpixel(mousex,mousey)
    }
    
}

/* */
/*  */
