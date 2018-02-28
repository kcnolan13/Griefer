/// @description avatar popups and promoted,demoted
draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_set_color(c_white)

var scale_tol = 0.25

if av_popup = noone
    av_popup_drawn = false
    
menu_mode = string(menu_mode)

if room = rm_login
{
    with gravatar
    {
        draw_set_alpha(1)
        draw_set_halign(fa_center)
        draw_set_font(fnt_hud_big)
        var yoff = 64*3.2-30
        var xoff = string_width(string_hash_to_newline(string(varRead("pName"))))/2
        draw_namerank(capwords(varRead("pName")), varRead("rank"), x - xoff,y - yoff, 1, c_black)
    }

    for (var i=0; i<instance_number(gravatar); i++)
    {
        ID = instance_find(gravatar,i)
        
        var yoff = 64*3.2-30
        var xoff = string_width(string_hash_to_newline(string(objVarRead(ID,"pName"))))/2
    
        if ID.hover_counter > ID.hover_delay and not instance_exists(modal_dialogue)
        {
            if not drawing_grav_popup
            {
                audio(snd_scroll3,1)
            }
            
            drawing_grav_popup = 2
            
            //DRAW THE PLAYER POPUP
            draw_player_popup_ext(cursor.x,cursor.y,capwords(objVarRead(ID,"pName")),objVarRead(ID,"rank"),objVarRead(ID,"global_rank"),objVarRead(ID,"true_skill"),
                objVarRead(ID,"helmet0"),objVarRead(ID,"hat0"),1,is_bot(ID))
        }
    }
}

if menmode() = "stats"
{
    with gravatar
    {
        draw_set_alpha(1)
        draw_set_halign(fa_center)
        draw_set_font(fnt_hud_big)
        var yoff = 64*4.5
        var xoff = string_width(string_hash_to_newline(string(varRead("pName"))))/2+32
        draw_namerank(capwords(varRead("pName")), objVarRead(stat_manager,"rank"), x - xoff,y - yoff, 1, c_white)
    }
}

for (var i=0; i<instance_number(avatar); i++)
{
    ID = instance_find(avatar,i)
    if ID.visible and menu_mode != "armory" and menu_mode != "stats" and real(objVarRead(ID,"pName")) != BAD_READ
    {
        draw_set_alpha(1)
        draw_set_halign(fa_center)
        draw_set_font(fnt_hud_big)
        
        if room = rm_menu
        {
            if menu_mode = "play"
                var yoff = 64*3.25
            else
                var yoff = 64*4.25
        }
        else var yoff = 64*3.2-30
        
        var xoff = string_width(string(objVarRead(ID,"pName")))/2
		var prename = capwords(objVarRead(ID,"pName"))
        draw_namerank(prename, objVarRead(ID,"rank"), ID.x - xoff,ID.y - yoff, 1, c_white)
        //draw_text(ID.x,ID.y - 64*3,objVarRead(ID,"pName"))
        
        if DEBUG {
            draw_text(ID.x,ID.y - 64*3.35, objVarRead(ID,"uniqueId"))
			draw_text(ID.x,ID.y - 64*4.35, capwords(objVarRead(ID,"pName")))
		}
    }
    if av_popup = ID and menu_mode != "armory" and ID.visible and ID.hover_counter > ID.hover_delay and not instance_exists(modal_dialogue)
    {
        if not av_popup_drawn
        {
            audio(snd_scroll3,1)
            av_popup_drawn = true
        }
        
        //DRAW THE PLAYER POPUP
        draw_player_popup_ext(cursor.x,cursor.y,capwords(objVarRead(av_popup,"pName")),objVarRead(av_popup,"rank"),objVarRead(av_popup,"global_rank"),objVarRead(av_popup,"true_skill"),
            objVarRead(av_popup,"helmet0"),objVarRead(av_popup,"hat0"),1,is_bot(av_popup))
        
        //GET CLICKED!
        if not is_bot(ID) and not popup_exists() and (input_check_pressed(mapped_control(C_JUMP)) or mouse_check_button_pressed(mb_left)) and not lock_armory and menmode() != "armory"
        {
            show_player_stats(objVarRead(ID,"pName"))
        }
    }
}

///real time step
real_time_step()

///debug
if 1=0
{
    draw_set_color(c_white)
    draw_flash_compensate()
    draw_set_font(fnt_hud)
    draw_set_halign(fa_left)
    draw_set_valign(fa_middle)
    
    pinc = 0
    with player
    {
        draw_text(WVIEW*2/3,HVIEW*1/4+32*other.pinc,string_hash_to_newline("Player "+playerName(id)+" pNum = "+string(varRead("pNum"))))
        other.pinc ++
    }
    
    pinc = 0
    with avatar
    {
        draw_text(WVIEW*1/4,HVIEW*1/4+32*other.pinc,string_hash_to_newline("Avatar "+playerName(id)+" pNum = "+string(varRead("pNum"))+", override = "+string(varRead("pNum_override"))))
        other.pinc ++
    }
}


///HUD
master_scale = 1*match_scale//HVIEW/768*match_scale

if global.map_editor return false

if in_match() and ((draw_killed_by and do_draw_killed_by) or (draw_you_killed and name_you_killed != ""))
{
    draw_set_font(fnt_splashscreen)
    draw_set_color(c_white)
    draw_flash_compensate()
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    var killer_name = objVarRead(local_player,"killer")
    
    var modal_scale = 0.75
    
    if draw_you_killed and name_you_killed != ""
        killer_name = name_you_killed
    
    if killer_name != varRead("pName")
    {
        var killer_av = find_pname_avatar(killer_name)
        var dead_av = noone
        
        if draw_you_killed and name_you_killed != ""
            dead_av = find_pname_avatar(name_you_killed)
        else
        {
            modal_scale = 1
            dead_av = myAvatar()
            //printf("::: yours is the dead avatar")
        }
        
        if instance_exists(killer_av)
        {
            var row_sep = 94
            var starty = HVIEW/12
            var head_space = 64
            var row2_xoff = -1/2*(head_space+string_width(string_hash_to_newline(string(killer_name))))
            
            var blood_color = c_red
            if instance_exists(dead_av)
            {
                blood_color = objVarRead(dead_av,"blood_color")
            } else printf("::: WARNING: couldn't locate dead avatar to find blood color for killed display")
            
            if modal_scale = 1
                draw_splats(WVIEW/2,starty+row_sep*1,1.15,blood_color,0.15)
            
            with killer_av
                draw_avatar_head(WVIEW/2+row2_xoff*modal_scale,starty+row_sep*modal_scale,id,0,1,1,FL_NOBAR)
                
            var kill_txt = "You Were Killed By: "
            
            if draw_you_killed and name_you_killed != ""
                kill_txt = "You Killed: "
                
            draw_text_transformed(WVIEW/2,starty,string_hash_to_newline(kill_txt),modal_scale,modal_scale,0)
            draw_set_halign(fa_left)
            draw_text_transformed(WVIEW/2+(row2_xoff+head_space)*modal_scale,starty+row_sep*modal_scale,string_hash_to_newline(string(killer_name)),modal_scale,modal_scale,0)
        }
    }
    else
    {
        var row_sep = 94
        var starty = HVIEW/12
        var head_space = 64
        var row2_xoff = -1/2*(head_space+string_width(string_hash_to_newline(string(killer_name))))
        draw_splats(WVIEW/2,starty+row_sep*1,1.15,objVarRead(myAvatar(),"blood_color"),0.15)
        draw_text_transformed(WVIEW/2,starty+64,string_hash_to_newline("You Killed Yourself..."),modal_scale,modal_scale,0)
    }
}

if not match_ending()
{
    if (starting_match) and not instance_exists(modal_controls) and not snapshot_mode
    {
        draw_set_color(c_white)
        draw_set_halign(fa_center)
        draw_set_valign(fa_center)
        
        var rw = WVIEW+20
        var rh = 64*1.5
        var rtop = 18
        var rbottom = rtop+rh
        draw_set_alpha(0.5)
        draw_rectangle_colour(WVIEW/2-rw/2,rtop,WVIEW/2+rw/2,rtop+rh,c_black,c_black,c_black,c_black,false)
        draw_set_alpha(1)
        
        draw_set_font(fnt_hud_biggest)
        draw_set_valign(fa_top)
        draw_text(0+WVIEW/2,rtop+12,string_hash_to_newline(string(game_mode_name_long(varRead("game_mode")))+" on "+string(global.map_names[room])))
        
        draw_set_font(fnt_hud_medium)
        draw_set_valign(fa_bottom)
        draw_text(0+WVIEW/2,rbottom-12,string_hash_to_newline("Starting Match . . . "+string(ceil(starting_match/30))))
        draw_set_valign(fa_center)
    }
    
    //don't let killed by overlap with promoted text
    do_draw_killed_by = draw_killed_by
    
    if do_draw_killed_by
    {
        with action_word
        {
            if init_as_promoted
                net_manager.do_draw_killed_by = false
        }
    }
    
    if bot_override
    {
        /*if instance_exists(local_player) and in_match() and rtime() > 30 
            and nth_frame(5*30)
        {
            objVarWrite(local_player,"rank",ceil(random_range(5,25)))   
        }*/
        draw_set_halign(fa_right)
        draw_set_valign(fa_top)
        draw_set_color(c_white)
        draw_set_font(fnt_hud)
        draw_flash_compensate()
        draw_set_alpha(0.8)
        draw_text(0+WVIEW-64,0+HVIEW-64,string_hash_to_newline("AI Override"))
    }
    
    if instance_exists(local_player)
    {
        if not instance_exists(modal_controls)
        {
            with local_player
            {
                if respawn_counter and not net_manager.starting_match and not hide_spawn_text
                    with other.id
                    {
                        draw_set_font(fnt_splashscreen)
                        draw_set_color(c_white)
                        draw_set_halign(fa_center)
                        draw_set_valign(fa_center)
                        if local_player.spawn_fail_message = ""
                            draw_text(0+WVIEW/2,0+HVIEW/2,string_hash_to_newline("Respawning . . . "+string(ceil(local_player.respawn_counter/30))))
                        else
                            draw_text(0+WVIEW/2,0+HVIEW/2,string_hash_to_newline(local_player.spawn_fail_message+" "+string(ceil(local_player.respawn_counter/30))))
                    }
            }
    
            if instance_exists(local_player.weapon_contemplating) and not match_starting() and not match_ending()
            {
                printf("local_player = "+string(local_player))
                printf("local_player.weapon_contemplating = "+string(local_player.weapon_contemplating))
                //printf(room_counter+" --> drawing weapon_contemplating")
                draw_weapon_slot(local_player.weapon_contemplating,0+WVIEW-sprite_get_width(spr_weapon_slot)/2*master_scale-border,0+(8+1.75*(sprite_get_height(spr_weapon_slot)+border+8))*master_scale,master_scale,1,FL_NORMAL)
                draw_set_color(c_white)
                draw_flash_compensate()
                draw_set_font(fnt_hud)
                draw_set_alpha(1)
                draw_set_halign(fa_right)
                draw_set_valign(fa_center)
                draw_text(0+WVIEW-sprite_get_width(spr_weapon_slot)*master_scale-border-10,0+(sprite_get_height(spr_weapon_slot)*1.75+border*2.25+2+8)*master_scale,string_hash_to_newline("["+get_input_name(mapped_control(C_PICKUP))+"]"))
            } //else printf("ERROR: no weapon_contemplating")
        }
        
        if local_player.weapon_wheel_alpha > 0 and not match_starting() and not match_ending()
        {
            show_scores = 0
            draw_weapon_wheel(local_player,0+WVIEW/2,0+HVIEW/2,local_player.weapon_wheel_alpha, master_scale)
        }
    
        if instance_exists(objVarRead(local_player,"active_weapon")) and not match_starting() and not match_ending()
        {
            border = 16
            draw_weapon_slot(objVarRead(local_player,"active_weapon"),0+WVIEW-sprite_get_width(spr_weapon_slot)/2*master_scale-border,0+(sprite_get_height(spr_weapon_slot)/2+border+8)*master_scale,master_scale,1,FL_NORMAL)
        }
    }
}

/* */
///scores and win popups and starting match countdown

if global.map_editor return false

if win_countdown
    win_countdown --
    
if varRead("end_match_coming") and win_countdown < -90
{
    win_countdown = match_countdown_max
}

if room = rm_lobby
{
    draw_set_font(fnt_hud_big)
    draw_set_color(c_black)
    draw_set_valign(fa_bottom)
    draw_set_halign(fa_center)
    if room_counter > 30*5
    {
        if instance_exists(bn_vote) and menmode() = "lobby"
        {
            draw_set_alpha(bn_vote.alpha)
            //draw_text(room_width/2,room_height/2+28,"Vote for Next Map")
            draw_set_alpha(1)
        }
    }
}
    
if ((show_scores > 0) and not match_ending() or (room_counter > 30*2 and room_counter < 30*7)) and (in_match() and room_counter > 30*3)//or room=rm_match_end
{
    var sy = HVIEW/2 - global.row_height*(instance_number(avatar)/2+2)
    var do_draw = true
    var dalph = 1
    if instance_exists(modal_controls)
    {
        sy += 72
        dalph = 0.7
        if modal_controls.mode_index != 0 or modal_controls.fade_out
        {
            do_draw = false
            show_scores = 0
        }
    }
        
    if not disable_scores and do_draw  and not snapshot_mode
    {
        draw_set_alpha(dalph)
        draw_score_table(WVIEW/2 - global.table_width/2, sy)
        draw_set_alpha(1)
    }
    //draw_scores(64,16)
}

if match_ending()
{
    if win_countdown > match_countdown_max/2
    {
        //WIN POPUP
        //first figure out who won
        
        if varRead("game_mode") = "tdm"
        {
            if match_collapsed
            {
                av_head = find_pname_avatar(playerName(myPlayer()))
                
                if av_head != noone
                {
                    titulo = ""+objVarRead(av_head,"pName")+"'s Team"
                    subtitulo = "Won The Match"
                    win_color = team_color_pname(playerName(av_head))
                } else
                {
                    printf("ERROR: should not be getting tied match in draw_GUI_4 when match collapsed")
                    titulo = "The Match Is A Tie"
                    subtitulo = ""
                    win_color = c_dkgray
                }
            }
            else
            {
                if team_kill_total(team0) > team_kill_total(team1)
                {
                    ds_grid_sort(team0,0,false)
                    av_head = ds_grid_get(team0, 1, 0)
                } else if team_kill_total(team1) > team_kill_total(team0)
                {
                    ds_grid_sort(team1,0,false)
                    av_head = ds_grid_get(team1, 1, 0)
                } else 
                {
                    av_head = noone
                    win_color = c_black
                }
                
                if av_head != noone
                {
                    win_color = team_color_pname(playerName(av_head))
                    titulo = ""+objVarRead(av_head,"pName")+"'s Team"
                    subtitulo = "Won The Match"
                } else
                {
                    titulo = "The Match Is A Tie"
                    subtitulo = ""
                    win_color = c_black
                }
            }
        }
        else
        {
             if match_collapsed
            {
                av_head = find_pname_avatar(playerName(myPlayer()))
                
                if instance_exists(av_head)
                {
                    titulo = ""+objVarRead(av_head,"pName")
                    subtitulo = "Won The Match"
                    win_color = team_color_pname(playerName(av_head))
                } else
                {
                    printf("ERROR: should not be getting tied match (FFA) in draw_GUI_4 when match collapsed")
                    titulo = "The Match Is A Tie"
                    subtitulo = ""
                    win_color = c_black
                }
            }
            else
            {
                ds_grid_sort(team_all,0,false)
                av_head = ds_grid_get(team_all,1,0)
                
                if ds_grid_get(team_all,0,0) = ds_grid_get(team_all,1,0)
                {
                    av_head = noone
                }
                if av_head != noone
                {
                    titulo = ""+objVarRead(av_head,"pName")
                    subtitulo = "Won The Match"
                    win_color = team_color_pname(playerName(av_head))
                }
                else
                {
                    titulo = "The Match Is A Tie"
                    subtitulo = ""
                    win_color = c_black
                }
            }
        }
        
        win_popup_scale = lerp_real(win_popup_scale,win_popup_scale_max,win_popup_lerp_real)
        win_popup_alpha = lerp_real(win_popup_alpha,win_popup_alpha_max,win_popup_lerp_real)
        draw_set_font(fnt_hud)
        //NOW DRAW THE WIN POPUP
        draw_win_popup_centered(WVIEW/2,HVIEW/2,win_popup_width,win_popup_height,win_color,win_popup_scale,win_popup_alpha,av_head,titulo,subtitulo)
    }
    else
    {
        if not disable_scores
            draw_score_table(WVIEW/2 - global.table_width/2, HVIEW/2 - global.row_height*(instance_number(avatar)/2+2))
    }
    
}

if room = rm_lobby and came_from_match and not lobby_match_countdown and  menu_mode != "lottery_steal" and menu_mode != "armory" and menu_mode != "challenges" and menu_mode != "settings" and menu_mode != "stats"
{
    if not disable_scores
        draw_score_table(WVIEW/2 - global.table_width/2, 64+armory_ysep+12)
}

if in_match() and not match_ending() and instance_exists(myAvatar()) and room_counter > 30*3  and not snapshot_mode
{
    var av_head0, av_head1
    var score0, score1
    
    //DRAW HEADS WITH SCORES
    if varRead("game_mode") = "tdm"
    {
        av_head0 = ds_grid_get(team0,1,0)
        score0 = team_kill_total(team0)
        
        av_head1 = ds_grid_get(team1,1,0)  
        score1 = team_kill_total(team1) 
            
    }
    else
    {
        av_head0 = my_doll
        score0 = objVarRead(my_doll,"match_kills")
        
        //printf("av_head0 is "+objVarRead(av_head0,"pName"))
        //printf("av_head0 ("+objVarRead(av_head0,"pName")+") has "+objVarRead(av_head0,"match_kills")+" match_kills")
        
        av_head1 = ds_grid_get(team_all,1,0)
        if objVarRead(av_head1,"pName") = objVarRead(my_doll,"pName")
            av_head1 = ds_grid_get(team_all,1,1)
        
        score1 = objVarRead(av_head1,"match_kills")
        
        //printf("av_head1 is "+objVarRead(av_head1,"pName"))
        //printf("av_head1 ("+objVarRead(av_head1,"pName")+") has "+objVarRead(av_head1,"match_kills")+" match_kills")
        
        //print_ds_grid(team_all)
    }

    //you now have handles to both avatars whose heads you need to draw
    var head_scale = 1.15
    var head_width = sprite_get_width(spr_head)*2*head_scale
    var head_height = sprite_get_height(spr_head)*2*head_scale
    
    var xhead = armory_ysep*master_scale+head_width/2*master_scale
    var yhead = armory_ysep*master_scale+head_height/2*master_scale
    
    draw_avatar_head(xhead, yhead, av_head0, score0, head_scale*master_scale, 1, FL_NORMAL)
    draw_avatar_head(xhead+head_width*1*master_scale, yhead, av_head1, score1, head_scale*master_scale, -1, FL_NORMAL)
}

if lobby_match_countdown and instance_exists(next_map_final)//and not waiting_for_data() and varRead("lobby_wait_time")/30 < 6 and not instance_exists(ui_countdown)
{
    //ui_countdown = popup_loading(WVIEW/2,HVIEW/2)
    //ui_countdown.is_ui_countdown = true
    
    next_map_final.text = "Match Countdown    "+string(time_30steps_2countdown(varRead("lobby_wait_time")))
    
    draw_set_color(c_black)
    if varRead("lobby_wait_time")/30 < 8
        draw_set_alpha(0.9 - max(0,(varRead("lobby_wait_time")/30)/8))
    else draw_set_alpha(0)
    draw_rectangle_colour(0,0,WVIEW,HVIEW,c_black,c_black,c_white,c_white,false)

    //draw_text(next_map_final.x,next_map_final.y+48,"Match Countdown ... "+string(ceil(varRead("lobby_wait_time")/30)))
    
}

/* */
///draw server disconnected
if not server_found
{
    if not reconnect_timer
    {
        reconnect_timer = 30*10
    }
    
    var dialogue = waiting_for_data()
    if not dialogue
    {
        draw_alert(cursor.x,cursor.y,"Connection Lost","","Press [SPACE] to Retry ... "+string(round(reconnect_timer/30)),c_red)
    }
    else
    { 
        dialogue.load_closable = false
        dialogue.color = web_hsv(0,100,30)
        dialogue.text = "Connection Failed ... "+string(ceil(reconnect_timer/30))
    }
}

/* */
/*  */
