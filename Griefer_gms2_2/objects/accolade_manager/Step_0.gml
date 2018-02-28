/// @description print grid to screen sometimes

if nth_frame(5*30)
{
    //print_ds_grid(grid)
}

///manage end-of-match accolades
if in_match() and match_ending() and not spawned_grid
{
    if not match_end_accs and not computed_match_end_accs
    {
        match_end_accs = true
        //note that this function actually awards the accolades as needed
        force_accolade_sound = true
        match_end_accolades()
        force_accolade_sound = false
        spawn_grid_delay = 1*30
    }
    
    if spawn_grid_delay > 0
    {
        spawn_grid_delay --
    }
    else
    {
        spawned_grid = true
        printf("::: creating match end accolade grid")
        with accolade_generic instance_destroy()
        
        grid_hsep = match_hsep
        create_accolade_grid(64*1.5,64*1.5,match_xoff+acc_width*3+match_hsep*2,HVIEW,fa_left,fa_center,5,COL_MATCH_TOTAL,false,0)
    }
}

///manage menu accolade grids

if not in_match() and room != rm_login
{
    if menmode() = "stats" or menmode() = "lottery_steal"
    {
        
        if acc_popup_id != noone
        {
            going_to_switch_can_draw = true
            with accolade_generic
            {
                if show_popup and id=accolade_manager.acc_popup_id
                    other.going_to_switch_can_draw = false
            }
            if going_to_switch_can_draw
                acc_popup_id = noone
        }
        
        if not instance_exists(accolade_generic)
        {
            spawned_grid = false
        }
        
        if menmode() = "stats"
        {
            switch (stat_manager.stat_tab)
            {
                case "Leaderboards":
                    spawned_grid = false
                    fade_modal(accolade_generic)
                    fade_modal(bg)
                    fade_modal(chev_left)
                    fade_modal(chev_right)
                break
                
                default:
                    if accolades_received() and not spawned_grid and not waiting_for_data()
                    {
                        var bg_yoff = 10
                        
                        if not instance_exists(bg)
                        {
                            bg = instance_create(grid_xmid,grid_ymid+bg_yoff,modal_window)
                            bg.highlightable = false
                            bg.alpha_max = 0.7
                            bg.halign = fa_center
                            bg.valign = fa_center
                            bg.width = grid_width+64
                            bg.height = 102
                            bg.birth_delay = 15
                            with (bg) modal_aligns()
                            bg.color = c_black
                            //bg.header_text = global.accolade_name+"s"
                            bg.header_yoff = 8
                            bg.header_font = fnt_hud
                            bg.header_text_color = c_white
                            bg.menu_mode = "stats"
                        }
                        
                        var chev_width = bg.height/2
                        var chev_delay = 30
                       
                        if not instance_exists(chev_left) and not instance_exists(chev_right)
                        {
                            chev_left = instance_create(grid_left-chev_width*1.5,grid_ymid+bg_yoff,bn_typical)
                            chev_left.submit_action = scroll_accolades
                            chev_left.chevron_left = true
                            chev_left.width = chev_width
                            chev_left.height = bg.height
                            chev_left.text = ""
                            chev_left.image = icon_chevron_lr
                            chev_left.img_index = 0
                            chev_left.image_stretch = false
                            chev_left.birth_delay = chev_delay
                            chev_left.menu_mode = "stats"
                            
                            chev_right = instance_create(grid_right+chev_width*1.5,grid_ymid+bg_yoff,bn_typical)
                            chev_right.submit_action = scroll_accolades
                            chev_right.chevron_right = true
                            chev_right.width = chev_width
                            chev_right.height = bg.height
                            chev_right.text = ""
                            chev_right.image = icon_chevron_lr
                            chev_right.img_index = 1
                            chev_right.image_stretch = false
                            chev_right.birth_delay = chev_delay+10
                            chev_right.menu_mode = "stats"
                        }
                        
                        spawned_grid = true
                        var col = COL_TOTAL
                        if stat_manager.stat_tab = stat_manager.tabs[1]
                           col =  COL_BOT_TOTAL
                           
                        grid_hsep = stats_hsep
                        create_accolade_grid(grid_left+24,grid_ymid,grid_right,room_height,fa_left,fa_center,0,col,true,0)
                        with accolade_generic
                        {
                            menu_mode = "stats"
                        }
                    }
                    
                    //update that stupid scrollable grid
                    update_scrollable_accolade_grid()
                break
            }
        }
        else
        {
            if not spawned_grid and instance_exists(xp_bar.accw) and xp_bar.accw.popped_in
            {
                accw = xp_bar.accw
                spawned_grid = true
                create_accolade_grid(accw.x,accw.top+70+accw.header_height,accw.x+256,room_height,fa_left,fa_left,0,COL_MATCH_TOTAL,FL_TOP_MEDALS,1)
            }
        }
    }
    else //not in stats mode
    {
        spawned_grid = false
        fade_modal(accolade_generic)
        fade_modal(bg)
        fade_modal(chev_left)
        fade_modal(chev_right)
    }
}

