/// @description keepalive and force sync + full_screen + vsync + draw_you_killed

if reconnect_timer
{
    reconnect_timer = sub_real(reconnect_timer,1)
    if not reconnect_timer
    {
        try_server_reconnect()
    }
}

if draw_you_killed
{
    draw_you_killed = sub_real(draw_you_killed,1)
    if not draw_you_killed
        name_you_killed = ""
}

var fs = truthval(global.gc[GC_FULLSCREEN,1])
if full_screen != fs
{
    full_screen = fs
    window_set_fullscreen(full_screen)
}

if not cross_referenced_options and rtime() > 30*2.5
{
    cross_referenced_options = true
    
    var swf_aa = global.gc[GC_AA_LEVEL,1]
    if draw_get_swf_aa_level() != swf_aa
    {
        draw_set_swf_aa_level(swf_aa)
        
    }
    
    var aa = display_aa
    if aa < 2       aa = 0
    else if aa < 4  aa = 2
    else if aa < 8  aa = 4
    else            aa = 8
    if truthval(global.gc[GC_VSYNC,1]) != global.vsync
    {
        global.vsync = truthval(global.gc[GC_VSYNC,1])
        if not truthval(global.gc[GC_VSYNC,1])
            display_reset(0,false)
        else
            display_reset(aa,true)
    }
    
}

if force_sync_countdown
{
    force_sync_countdown --
    if not force_sync_countdown
    {
        sync_my_doll()
        sendMessageReal("force_sync_doll",1)
    }
}

if keepalive_timer
{
    keepalive_timer --
    if not keepalive_timer
    {
        keepalive_timer = keepalive_timeout
        //printf("::: checking keepalive")
        if isAlive() = 1
        {
            //printf(":::IS ALIVE")
            server_found = true
            keepalive_missed = 0
            keepAlive()
        }
        else
        {
            keepalive_missed ++
            printf("::: KEEPALIVE TIMEOUT")
            keepAlive()
            
            if keepalive_missed > keepalive_missable
            {
                server_found = false
            }
        }
    }
}

///adjust physics speed to match frame rate...?
if in_match()
{
    physics_world_gravity(0,real_speed(global.phys_world_grav))
    //physics_world_update_speed(max(global.phys_world_spd,real_speed(global.phys_world_spd)))

    if nth_frame(15)
    {
        if physics_going and not truthval(global.gc[GC_RAGDOLLS,1])
        {
            physics_pause_enable(true)
            net_manager.physics_going = false
        }
        else if not physics_going and truthval(global.gc[GC_RAGDOLLS,1])
        {
            physics_pause_enable(false)
            net_manager.physics_going = true
        }
    }
}

///testing

if nth_frame(15)
{
    //rag_rain_limbs(floor(random_range(1,2.99)))
}

///deactivate rampant cursors
active_cursors = 0

for (var i=0; i<instance_number(cursor_generic); i++)
{
    ID = instance_find(cursor_generic,i)
    if ID.active
    active_cursors++
}

if active_cursors > 1
{
    printf(":::deactivating duplicate cursors")
    cursor_generic.active = false
}

if instance_exists(NO_HANDLE)
    printf("ERROR: NO_HANDLE DOES EXIST!!!\\n\\n")

///lobby networking and game mode stuff
if room = rm_lobby and instance_exists(my_doll) 
{
    if varRead("lobby_wait_time") <= lobby_match_countdown_time
    {
        lobby_match_countdown = true
    }
    else
    {
        //override whatever the lobby_wait_time thinks it is if you got a lock_armory
        if lock_armory
        {
            varWrite("lobby_wait_time",lobby_match_countdown_time)
        }
        
        if objVarRead(my_doll,"pNum") = global.lowest_pnum and nth_frame(15)
        {
            if SUPER_DEBUG
                printf("sending lobby wait time")
            //send lobby wait time to everyone else @ 1 Hz if you are player 0
            obj_sendval_real(id,"lobby_wait_time",varRead("lobby_wait_time"),FL_NORMAL)
        }
    }
}
else 
{
    lobby_match_countdown = false
}

if not bot_match and is_string(varRead("game_mode")) 
{
    if string_count("bot",varRead("game_mode"))
    {
        printf("ENTERING A BOT MATCH")
        bot_match = true
        
        if string_count("versus",varRead("game_mode"))
            player_limit = 2
        else
            player_limit = 4
    }
}


///META STUFF and avatar lerping
if drawing_grav_popup   
    drawing_grav_popup --
    
if login_when_ready
{
    if not instance_exists(modal_splat)
    {
        login_when_ready = false
        logIn(objVarRead(net_manager,"pName"))
        printf("::: LOGGING IN")
        room_goto(rm_menu)
    }
}
    
av_popup = noone

if room = rm_menu
    av_scale_highlighted = av_scale_highlighted_normal*(av_scale_menu/av_scale_lobby)
else
    av_scale_highlighted = av_scale_highlighted_normal

if room = rm_menu and came_from_match
    boot_loitering_avatars()
    
if room = rm_menu and instance_exists(my_doll) and instance_exists(stat_gravatar)
{
    var datObj = my_doll
    if menmode() = "stats"
        datObj = stat_gravatar
        
    var curscale = objVarRead(datObj,"animation_scale")
        
        //avatar popups and scale lerp_realing
        if av_popup != noone or menmode() = "armory" or menmode() = "stats" or not collision_rectangle(datObj.x-curscale*av_xbd, datObj.y-curscale*av_ybd, datObj.x+curscale*av_xbd, datObj.y+curscale*av_ybd, cursor, false, false)
        {
            datObj.hover_counter = 0
            if menu_mode != "armory"
                objVarWrite(datObj,"animation_scale",lerp_real(objVarRead(datObj,"animation_scale"),av_scale_play,0.5))
            else
                objVarWrite(datObj,"animation_scale",lerp_real(objVarRead(datObj,"animation_scale"),av_scale_menu,0.5))
        }
        else
        {
            datObj.hover_counter++
            
            av_popup = datObj
            
            if menmode() != "armory"
                av_scale_highlighted = av_scale_highlighted_normal*(av_scale_play/av_scale_menu)
            else av_scale_highlighted = av_scale_highlighted_normal
            
            objVarWrite(datObj,"animation_scale",lerp_real(objVarRead(datObj,"animation_scale"),av_scale_menu*av_scale_highlighted/av_scale_menu,0.5))
        }
}

if room = rm_lobby
{
    if mode_counter
    {
        mode_counter -= real_speed(1)
        
        if mode_counter < 1
            mode_counter = 0
            
        if not mode_counter
        {
            /*with bn_play event_perform(ev_mouse,ev_left_press)
            menu_mode = "lobby"
            hide_avatars = false*/
        }
    }

    num_players = instance_number(avatar)
    av_padding = room_width/instance_number(avatar)
    
    for (var i=0; i<num_players+1; i++)
    {
        if i = num_players
        {
            if menmode() != "stats" continue
            
            ID = stat_gravatar
            if not instance_exists(stat_gravatar)
            {
                printf("ERROR: no stat gravatar to be found")
                continue
            }
            //else if objVarRead(ID,"pName") = objVarRead(my_doll,"pName")
              //  ID = my_doll
        }
        else ID = instance_find(avatar,i)
        
        var curscale = objVarRead(ID,"animation_scale")
        
        //avatar popups and scale lerp_realing
        if av_popup != noone or menmode() = "armory" or menmode() = "stats" or not collision_rectangle(ID.x-curscale*av_xbd, ID.y-curscale*av_ybd, ID.x+curscale*av_xbd, ID.y+curscale*av_ybd, cursor, false, false)
        {
            ID.hover_counter = 0
    
            if menu_mode != "armory" or not is_my_avatar(ID)
                objVarWrite(ID,"animation_scale",lerp_real(objVarRead(ID,"animation_scale"),av_scale_lobby,0.5))
            else
                objVarWrite(ID,"animation_scale",lerp_real(objVarRead(ID,"animation_scale"),av_scale_menu,0.5))
        }
        else
        {
            ID.hover_counter++
            av_popup = ID
                
            var targ = av_scale_lobby
            if menu_mode = "armory"
                targ = av_scale_menu
            
            objVarWrite(ID,"animation_scale",lerp_real(objVarRead(ID,"animation_scale"),targ*av_scale_highlighted/av_scale_menu,0.5))
        }
        
        switch (menu_mode)
        {
            case "lobby":
                objVarWrite(ID,"dude_y",lobby_dude_y)
                var pnum = objVarRead(ID,"pNum")
                
                if not lobby_match_countdown
                    pnum = i
                
                var xtarget = room_width/2
                var dat_sign = 1
                
                if pnum < instance_number(avatar)/2
                    dat_sign = -1
                
                if not string_count("ffa",varRead("game_mode"))
                {
                    if instance_number(avatar) < 3
                    {
                        xtarget = room_width/2+(64*5.25)*dat_sign
                    } else
                    {
                        if dat_sign = 1
                            pnum -= 2
                            
                        var avpad = 64*4
                        xtarget = room_width/2+(64*2.5+(avpad-32)*(pnum+0.5))*dat_sign
                    }
                }
                else
                {
                    xtarget = room_width/2
                    if pnum != 0
                        xtarget += 64*6.25*dat_sign
                }
                
                objVarWrite(ID,"dude_x",xtarget)
            break
            
            case "armory":
                if is_my_avatar(ID)
                {
                    dude_x = room_width/2
                    dude_y = room_height*1.75/3-64
                    objVarWrite(ID,"dude_x",room_width/2)
                    objVarWrite(ID,"dude_y",room_height*1.75/3-64)
                }
                else
                {
                    objVarWrite(ID,"dude_y",lobby_dude_y)
                    if ID.x < room_width/2
                        objVarWrite(ID,"dude_x",-64*8)
                    else
                        objVarWrite(ID,"dude_x",room_width+64*8)
                }
            break
            
            case "challenges":
                if is_my_avatar(ID)
                {
                    objVarWrite(ID,"dude_y",room_height*1.75/3-64)
                    objVarWrite(ID,"dude_x",-64*8)//room_width*1/9)
                }
                else
                {
                    objVarWrite(ID,"dude_y",lobby_dude_y)
                    if ID.x < room_width/2
                        objVarWrite(ID,"dude_x",-64*8)
                    else
                        objVarWrite(ID,"dude_x",-64*8)
                }
            break
            
            case "stats":
                if ID = stat_gravatar //or i=num_players
                {
                    objVarWrite(ID,"dude_y",room_height*1.75/3-32)
                    objVarWrite(ID,"dude_x",room_width*1/9)
                }
                else
                {
                    objVarWrite(ID,"dude_y",lobby_dude_y)
                    if ID.x < room_width/2
                        objVarWrite(ID,"dude_x",-64*8)
                    else
                        objVarWrite(ID,"dude_x",room_width+64*8)
                }
            break
            
            case "lottery_steal":
                if not is_my_avatar(ID) or true
                {
                    ID.y = -64*10
                    objVarWrite(ID,"myY",-64*10)
                    objVarWrite(ID,"dude_y",0-64*10)
                }
                else
                {
                    objVarWrite(ID,"dude_y",room_height*2/3-32)
                    objVarWrite(ID,"dude_x",room_width*1/8)
                }
            break
            
            default:
                objVarWrite(ID,"dude_y",lobby_dude_y)
                if ID.x < room_width/2
                    objVarWrite(ID,"dude_x",-64*8)
                else
                    objVarWrite(ID,"dude_x",room_width+64*8)
            break
        }
    }
    
    if varRead("lobby_wait_time") > 0
    {
        varSub("lobby_wait_time",real_speed(1))
    }
    else
    {
        varWrite("lobby_wait_time",0)
    }
}

if room = rm_menu or room = rm_lobby
{
    //if instance_exists(my_doll) and room = rm_menu
        //objVarWrite(my_doll,"animation_scale",av_scale_menu)
        
    if saving_armor
    {
        saving_armor = sub_real(saving_armor,1)
        if not saving_armor and saving_armor_reboot
        {
            griefer_restart()
        }
    }
        

    if armor_modified and menu_mode != "armory"
    {
        save_armory()
    }

    if (bparts_all_ready() and string_length(varRead("helmet0")) > 4)
    {
        printf("ERROR: body parts may have been overwritten with db values again.")
        printf("EXTRACTING AGAIN...")
        for (var i=0; i<10; i++)
        {
            bparts_ready[i] = bparts_get_ready(i)
        }
    }

    if room = rm_menu
    switch (menu_mode)
    {
        case "play":
            dude_x = room_width*3.85/5
            dude_y = room_height*1.75/3-64*2
        break
        
        case "armory":
            dude_x = room_width/2
            dude_y = room_height*1.75/3-64
        break
        
        case "challenges":
            dude_x = -64*8//room_width*1/9
            dude_y = room_height*1.75/3-64
        break
        
        case "stats":
            if instance_exists(stat_gravatar)
            {
                objVarWrite(stat_gravatar,"dude_x",room_width*1/9)
                objVarWrite(stat_gravatar,"dude_y",room_height*1.75/3-32)
            }
            dude_x = -9*64
            dude_y = room_height*1.75/3-64
        break
        
        case "settings":
            dude_x = -9*64
            dude_y = room_height*1.75/3-64
        break
        
        case "friends":
            dude_x = room_width*1/9
            dude_y = room_height*1.75/3-64
        break
        
        case "leaderboards":
            dude_x = -9*64
            dude_y = room_height*1.75/3-64
        break
        
        case "lottery_steal":
            //shouldn't be in this mode in the menu
            with bn_play event_perform(ev_mouse,ev_left_press)
            menu_mode = "play"
            mode_counter = 0
        break
    }
    
    if instance_exists(my_doll) and bparts_all_ready() and room = rm_menu
    {
        objVarWrite(my_doll,"dude_x",dude_x)
        objVarWrite(my_doll,"dude_y",dude_y)
    } else 
    {
        if SUPER_DEBUG and not room = rm_menu
            printf("NOTICE: my_doll does not exist")
    }
}

/* */
///map voting modal management
manage_voting_modals()

/* */
///show/hide control tips
if in_match()
{
    var yes = truthval(global.gc[GC_CONTROL_HINTS,1])
    if yes and not instance_exists(control_tips)
    {
        create_control_tips()   
    }
    else if not yes and instance_exists(control_tips)
    {
        hide_control_tips()
    }
}

/* */
///bpart management + cache management
for (var i=0; i<NUM_BPARTS; i++)
{
    if not bparts_ready[i] and room != rm_login
    {
        bparts_ready[i] = bparts_get_ready(i)
        
        //if all bparts are ready, create meta bparts
        if bparts_all_ready()
        {
            //instantiate all of the bpart objects
            instantiate_all_bparts()
        }
    }
}

if not in_match() and room != rm_login
{
    if menmode() = "armory" and nth_frame(30*6)
    {
        manage_cache()
    }
}

if varRead("cache") != ""
{
    //instantiate items that persisted from last time's cache
    printf("::: Importing Persistent Bparts Cache Data")
    var str = varRead("cache")
    printf("::: cache_str = "+string(str))
    while string_length(str) > 0
    {
        //printf("::: cache_str = "+string(str))
        
        var item
        var first_comma = string_pos(",",str)
        if first_comma > 0
        {
            item = string_copy(str,1,first_comma-1)
            str = string_copy(str,first_comma+1,string_length(str)-first_comma)
            source = bpart_extract_source(item)
            item = bpart_extract_sprite(item)
            if sprite_exists(item)
                printf("::: parsed next item: "+string(sprite_get_name(item)))
            else
                printf("ERROR: item sprite does not exist 1")
        }
        else
        {
            item = str
            str = ""
            source = bpart_extract_source(item)
            item = bpart_extract_sprite(item)
            if sprite_exists(item)
                printf("::: parsed last item: "+string(sprite_get_name(item)))
            else
                printf("ERROR: item sprite does not exist 2")
        }
        
        if item > 0 and sprite_exists(item)
        {
            printf("::: instantiating "+string(sprite_get_name(item)))
            instantiate_bpart(item,source,global.cache)
            //call for cache management
            alarm[11] = 15
        }
        else
        {
            printf("ERROR: invalid item in cache import: "+string(item))
        }
        
    }
    varWrite("cache","")
}

/* */
with (other) {
///create menu avatars
if (room = rm_menu or room = rm_lobby) and (room_counter > 30/2 and (not show_avatar or my_doll = noone) and bparts_all_ready())
{
    my_doll = find_pname_avatar(varRead("pName"))
    if my_doll != noone
    {
        printf("::: FOUND LOCAL AVATAR")
        objVarWrite(my_doll,"rank",varRead("rank"))
        objVarWrite(my_doll,"global_rank",varRead("global_rank"))
        if DEBUG
            printf("preparing local avatar...")
            
        show_avatar = true
        local_dollsync = true
        sync_my_doll()
        local_dollsync = false   
        objVarWrite(my_doll,"dude_x",dude_x)
        objVarWrite(my_doll,"dude_y",0)
        my_doll.x = dude_x
        my_doll.y = 0
        
        printf("::: creating stat gravatar")
        stat_gravatar = instance_create(0,0,gravatar)
        stat_manager.grav_name = varRead("pName")
        objVarWrite(stat_gravatar,"pName",varRead("pName"))
        objVarWrite(stat_gravatar,"uniqueId",hash_string(varRead("pName")))
        
        if new_user
        {
            printf("::: CREATING NEWUSER_BPARTS")
            scr_instantiate_newuser_bparts()
            new_user = false
        }
    }
}

/* */
}
///counters and var syncing to server
room_counter += real_speed(1)

if room = rm_lobby
{
    if string(menu_mode) = "lottery_steal"
    {
        lotto_counter++
    }
    else if lotto_counter > 0
    {
        lotto_counter = 0
    }
}

if starting_match 
{
    starting_match -= real_speed(1)
    
    if starting_match < 1
        starting_match = 0
    
    if starting_match and starting_match < 30 and not varRead("match_started")
    {
        obj_sendval_real(id, "match_started", 1, FL_NORMAL)
        varWrite("match_started",2)
    }
    
    if varRead("match_started") = 1 and starting_match
    {
        starting_match = 30
        varWrite("match_started",2)
    }
    
    if instance_exists(local_player)
    {
        if starting_match
            objVarWrite(local_player,"controllable",false)
        else
            objVarWrite(local_player,"controllable",true)
    }
    
}

//sync xp to server every 10 seconds
if (xp_before != varRead("xp") or rank_before != varRead("rank")) and room != rm_login
{
    //printf("ERROR: net_man xp = "+string(varRead("xp")))
    stat_update_real("xp",varRead("xp"),FL_NORMAL)
    stat_update_real("rank",varRead("rank"),FL_NORMAL)
}
xp_before = varRead("xp")
rank_before = varRead("rank")

/* */
///player physics, send frames, RECEIVE TRANSMISSIONS

//SEND FRAMELY PLAYER DATA
if instance_exists(myPlayer())
{
    send_frame()
}

//clear player physics updated flag
if in_match()
{
    with player
    {
        if myPlayer() != id and not is_bot(id)
        {
            varWrite("physics_updated",false)
        }
    }
}

//
//
//RECEIVE ALL TRANSMISSIONS
receive_transmissions()
//
//

//compute physics for un-updated players
if in_match()
{
    with player
    {
        if myPlayer() != id and not is_bot(id) and not varRead("physics_updated") and not match_ending()
        {
            hsp = varRead("net_hsp_true")
            vsp = varRead("net_vsp_true")
            //printf("::: "+playerName(id)+" is simulating with net_hsp_true = "+string(hsp)+", net_vsp_true = "+string(vsp))
            scr_basic_physics()
        }
    }
}

/* */
///END MATCH CONDITION -- gear stealing and lottery and whatnot

if instance_number(player) > 0 and rtime() > 10*30
{
    if (match_countdown > 0)
    {
        if not varRead("gearsteal_computed")
        {
            printf("::: SENDING END_MATCH_COMING")
            varWrite("end_match_coming",true)
            obj_update_real(id,"end_match_coming",FL_NORMAL)
            
            //THIS GUY (AND HIS TEAM) WON --> TIME TO STEAL GEAR!!!
            if varRead("game_mode") != "tdm"
            {
                tied_bot_match = false
                perform_everyones_steal_gear()
                varWrite("winning_pName",varRead("pName"))
                obj_update_string(id,"winning_pName",FL_NORMAL)
                printf("ERROR (not): sending winning_pName: "+varRead("winning_pName"))
            }
            else if instance_exists(local_player)
            {
                if is_team_leader(local_player)
                {
                    printf("local player is TEAM LEADER. computing gear stealing for everyone.")
                    perform_everyones_steal_gear()
                    varWrite("winning_pName",varRead("pName"))
                    obj_update_string(id,"winning_pName",FL_NORMAL)
                }
            }
        }
        
        match_countdown -= real_speed(1)
        if match_countdown < 1
            match_countdown = 0
        
        if (match_countdown = 0)
        {
            sendMessageReal("end_match",stat_manager.stat_flag)
            room_goto(rm_lobby)
        }
    } else if not varRead("end_match_coming") and instance_exists(local_player) {//(varRead("game_mode") != "tdm" or instance_exists(local_player) and (is_team_leader(local_player) or bot_match)) {
    
        //possibly trigger a match end based on local player's kills
        team_kills = objVarRead(local_player,"match_kills")//get_netstat_pname(varRead("pName"),"kills")
        you_win = false
        your_kills = team_kills
        winner = my_doll

        if team_kills >= kill_limit
            recompute_scores()

        if bot_match
        {
            you_win = true
            for (var n=0; n<instance_number(player); n++)
            {
                guy = instance_find(player,n)
                if is_bot(guy.id) //objVarRead(guy,"bot")
                {
                    var temp_kills = objVarRead(guy,"match_kills")
                    if temp_kills > team_kills
                    {
                        if temp_kills >= kill_limit
                            recompute_scores()
                            
                        team_kills = objVarRead(guy,"match_kills")
                        you_win = false
                        winner = find_pname_avatar(objVarRead(guy,"pName"))
                    }
                }
            }
        }

        //add all teammates' kills if in tdm
        if varRead("game_mode") = "tdm"
        {
            team_kills = 0
            for (i=0; i<instance_number(player); i++)
            {
                ID = instance_find(player,i)
                if is_local_teammate(ID) and not objVarRead(ID,"player_quit")
                    team_kills += objVarRead(ID,"match_kills")//get_netstat_pnum(objVarRead(ID,"uniqueId"),"kills")
            }
            
            if bot_match
            {
                team0_kills = 0
                team1_kills = 0
                
                for (var n=0; n<instance_number(player); n++)
                {
                    guy = instance_find(player,n)
                    if not objVarRead(guy,"player_quit")
                    {
                        if get_team(guy) = 0
                            team0_kills += objVarRead(guy,"match_kills")
                        else
                            team1_kills += objVarRead(guy,"match_kills")
                    }
                }
                
                if team0_kills > team1_kills
                {
                    team_kills = team0_kills
                    if get_team(local_player) = 0
                        you_win = true
                    else
                        you_win = false
                    recompute_scores()
                    winner = ds_grid_get(team0,1,0)
                }
                else if team1_kills > team0_kills
                {
                    team_kills = team1_kills
                    if get_team(local_player) = 1
                        you_win = true
                    else
                        you_win = false
                    recompute_scores()
                    winner = ds_grid_get(team1,1,0)
                }
                else 
                {
                    you_win = false
                    winner = noone
                }
            }
            
            //has everyone on the othe team quit?
            everyone_quit = true
            with player
            {
                if not varRead("player_quit") and get_team(id) != get_team(myPlayer())
                    other.everyone_quit = false
            }
            
            if everyone_quit
            {
                match_collapsed = true
                obj_sendval_real(id,"everyone_quit",true,FL_NORMAL)
                collapsed_pluralize = 0
                with player
                {
                    if varRead("player_quit")
                    {
                        other.collapsed_pluralize ++
                        if string_length(net_manager.collapsed_pname) < 2
                            net_manager.collapsed_pname = capwords(playerName(id))
                        else
                            net_manager.collapsed_pname += " and "+capwords(playerName(id))
                    }
                }
                match_countdown = match_countdown_max
                var dat_team = get_team(myPlayer())
                if dat_team > -1 and dat_team < 2
                    default_winner = playerName(ds_grid_get(dat_team,1,0))
                else
                    default_winner = playerName(myPlayer())
            }
            
        }
        else
        {
            //ffa or versus
            
            //has everyone on the othe team quit?
            everyone_quit = true
            with player
            {
                if not varRead("player_quit") and playerName(id) != playerName(myPlayer())
                    other.everyone_quit = false
            }
            
            if everyone_quit
            {
                obj_sendval_real(id,"everyone_quit",true,FL_NORMAL)
                collapsed_pluralize = 0
                
                with player
                {
                    if varRead("player_quit")
                    {
                        other.collapsed_pluralize++
                        if string_length(net_manager.collapsed_pname) < 2
                            net_manager.collapsed_pname = capwords(playerName(id))
                        else
                            net_manager.collapsed_pname += " and "+capwords(playerName(id))
                    }
                }
                
                match_countdown = match_countdown_max
                default_winner = playerName(myPlayer())
            }
        }
        
        if team_kills >= kill_limit
        {
            match_countdown = match_countdown_max
            printf("::: team/player has enough kills to end match: "+string(team_kills))
            printf("::: SETTING MATCH COUNTDOWN")
        }
    }
}

if varRead("everyone_quit")
{
    varWrite("everyone_quit",false)
    
    if not everyone_quit
    {
        everyone_quit = true
        default_winner = playerName(myPlayer())
        match_collapsed = true
        collapsed_pluralize = 0
        
        with player
        {
            if varRead("player_quit")
            {
                other.collapsed_pluralize ++
                if string_length(net_manager.collapsed_pname) < 2
                    net_manager.collapsed_pname = capwords(playerName(id))
                else
                    net_manager.collapsed_pname += " and "+capwords(playerName(id))
            }
        }
    }
    else
    {
        varWrite("everyone_quit",false)
    }
}

if varRead("end_match_coming") 
{
    //printf("ERROR: net_man uniqueID: "+string(varRead("uniqueId"))+", net_man winning_pName: "+string(varRead("winning_pName")))
    with player
        respawn_counter = 0

    came_from_match = true
    
    if not computed_winloss
        compute_winloss()
    
    if not lotto_ready
    {
        //fix any bpart_map corruption
        validate_knowledge_base_integrity()
        
        //figure out what gear you're getting
        perform_lottery()
        lotto_ready = true
    }
}

/* */
///SCORES -- SORT, HIDE, SHOW, RECOMPUTE
if (keyboard_check_pressed(vk_tab) or (global.using_gamepad and gamepad_button_check_pressed(global.devno,gp_select))) and instance_number(player) > 0 and room_counter > 30
{
    //printf("hiding scores")
    show_scores ^= 1
}

if in_match() and instance_exists(modal_controls)
{
    if modal_controls.mode_index = 0
        show_scores = true
    else
        show_scores = false
}

//sort scores @ 2 Hz
//see if anything sort-worthy has happened

if varRead("force_recompute_scores")
{
    varWrite("force_recompute_scores",false)
    force_recompute_scores = true
}

for (var i=0; i<instance_number(player); i++)
{
    var ID = instance_find(player,i)
    if objVarRead(ID, "match_points_previous") != objVarRead(ID,"match_points") or objVarRead(ID, "match_kills_previous") != objVarRead(ID,"match_kills") or objVarRead(ID, "match_deaths_previous") != objVarRead(ID,"match_deaths") or objVarRead(ID, "match_assists_previous") != objVarRead(ID,"match_assists")
    {
        printf(":::sortworthy!")
        sort_worthy = true
        break
    }
}

if in_match() and force_recompute_scores or (nth_frame(10) and sort_worthy and not disable_scores )
{
    recompute_scores()
}

/* */
/*  */
