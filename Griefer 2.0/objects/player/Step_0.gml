/// @description perform step
if perform_step != 0
    exit

///bparts_ready

debug_counter++
if not bparts_ready and is_string(varRead("helmet0"))
{       
    if varRead("helmet0") != "" and varRead("torso0") != ""
    and varRead("leg0") != "" and varRead("shin0") != ""
    and varRead("foot0") != "" and varRead("hat0") != ""
    and varRead("shoulder0") != "" and varRead("forearm0") != ""
    {
        varWrite("helmet0",bpart_extract_sprite(varRead("helmet0")))
        varWrite("torso0",bpart_extract_sprite(varRead("torso0")))
        varWrite("leg0",bpart_extract_sprite(varRead("leg0")))
        varWrite("shin0",bpart_extract_sprite(varRead("shin0")))
        varWrite("foot0",bpart_extract_sprite(varRead("foot0")))
        varWrite("hat0",bpart_extract_sprite(varRead("hat0")))
        varWrite("shoulder0",bpart_extract_sprite(varRead("shoulder0")))
        varWrite("forearm0",bpart_extract_sprite(varRead("forearm0")))
        bparts_ready = true
        
        //send bodyparts to other.id players?
        
    } else {
        if DEBUG
        {
            printf("bparts not ready for player #"+varRead("uniqueId"))
            printf(varRead("pName")+" : "+varRead("helmet0")+", "+varRead("foot0")+", "+varRead("hat0")+", "+varRead("torso0")+", "+varRead("forearm0")+", "+varRead("shoulder0")+", "+varRead("leg0")+", "+varRead("shin0")+", ")
        }
    }
}

if is_bot(id) and net_manager.room_counter > 5
    bparts_ready = true

action_inherited();
///counters and get assist and player quit
if rtime() > room_speed*5 and is_real(varRead("pName")) and real(varRead("pName")) = BAD_READ
{
    printf("ERROR: "+string(varRead("uniqueId"))+" has pName="+string(varRead("pName"))+". Reconciling with uniqueId")
    varWrite("pName",varRead("uniqueId"))
}

if not instance_exists(weapon_contemplating)
    time_since_wepcont += real_speed(1)
else time_since_wepcont = 0

if weapon_switch_delay
    weapon_switch_delay -= real_speed(1)

if weapon_switch_delay < 0
    weapon_switch_delay = 0
    

//if alive_counter % 30 = 0 and net_manager.local_player = id
//    printf("hp = "+varRead("hp"))
    
if varRead("player_quit")
{
    x = -50
    y = -50
    varWrite("myX",-50)
    varWrite("myY",-50)
    varWrite("visible",false)
    //varWrite("controllable",false)
    visible = false
}


if net_manager.local_player = id
{
    if varRead("hp") < 100 or match_starting() or match_ending()
    {
        with challenge_manager
        {
            ninja_time = 0
            untouched_kills = 0
        }
    } else
    {
        with challenge_manager
        {
            ninja_time += real_speed(1)
            if ninja_time > acc_data("ninja",COL_NEEDED)*30
            {
                //printf("::: ninja acc completed -- data in col_needed was: "+string(acc_data("ninja",COL_NEEDED)))
                total_stationary_players = 0
                with player
                {
                    if stationary_counter > stationary_threshold
                        other.total_stationary_players++
                }
                if total_stationary_players < 1
                {
                    complete_accolade("ninja")
                    ninja_time = 1
                }
                else 
                {
                    with challenge_manager
                    {
                        ninja_time = 0
                    }
                    printf(":::WARNING: unable to complete ninja accolade because "+string(total_stationary_players)+" players are stationary")
                }
            }
        }
    }
    if varRead("hp") < 25
    {
        if varRead("alive") and alive_counter > 10
            near_death = true
        else
            near_death = false
    } else if varRead("hp") > 90 and near_death
    {
        near_death = false
        with challenge_manager
        {
            complete_accolade("survivor")
            /*if acc_data("survivor",COL_TOTAL) >= near_deaths_needed and not challenge_is_complete(global.muscle)
            {
                complete_challenge(global.muscle_name)
            }*/
        }
    }
    
    if not in_flame(id)
    {
        obj_update_real(id,"fire_counter",FL_NORMAL)
        if varRead("fire_counter")
            varWrite("fire_counter",sub_real(varRead("fire_counter"),1))
    }

        if not input_check(mapped_control(C_MOVE_LEFT)) and not input_check(mapped_control(C_MOVE_RIGHT)) and varRead("animation") = "walk"
        {
            walking = false
            printf("manual standing override")
            animation_stand()
        }

    if varRead("flash_hp") < 75
    {
        //printf("flash_hp = "+varRead("flash_hp"))
        
        if not audio_is_playing(snd_flashed)
            audio(snd_flashed,1)
            
    } else if audio_is_playing(snd_flashed) audio_stop_sound(snd_flashed)
}

if varRead("alive")
{
    if varRead("hp") > 0
    {
        varWrite("visible",true)
        visible = true
    }
    
    alive_counter++
    if alive_counter < 30*1.5 and (net_manager.local_player = id or is_bot(id))
    {
        //guarantee that you spawn with your starting weapons
        ensure_weapons_spawned()
    }
}
else 
{
    alive_counter = 0
    varWrite("flash_hp",100)
    flash_recovery_delay_counter = 0
}

if (varRead("get_assist") > 0) and (net_manager.local_player = id or master_of(id))
{
    varSub("get_assist",1)
    varAdd("match_assists",1)
    varAdd("match_points",POINTS_ASSIST)
    varAdd("assists",1)
    obj_update_real(id,"match_assits",FL_NORMAL)
    obj_update_real(id,"match_points",FL_NORMAL)
    
    refresh_scoregrid()
    
    if myPlayer().id = id
    with challenge_manager
    {
        match_assists++
        spree_assists++
        
        if spree_assists = 3
            complete_accolade("3ass")
        else if spree_assists = 5
            complete_accolade("5ass")
        
        //if match_assists >= santa_assists and not challenge_is_complete("Santa Hat")
          //  complete_challenge("Santa Hat")
            
        //if match_assists >= iron_assists and not challenge_is_complete("Iron")
          //  complete_challenge("Iron")
        
    }   
    
    if not is_bot(id)
    {
        boom_delay = compute_boom_delay()
        boom = boom_boom_pow("+"+string(POINTS_ASSIST)+" Assist",global.action_word_color)
        boom.fnt = fnt_boom
        boom.scale = 1.25
        boom.birth_delay = boom_delay
        add_xp(XP_ASSIST,true,true,false)
        stat_update_real("assists",varRead("assists"),stat_manager.stat_flag)
    }
}

if hp_previous != varRead("hp")
{
    recovery_delay_counter = recovery_delay
}

if flash_hp_previous != varRead("flash_hp")
{
    flash_recovery_delay_counter = flash_recovery_delay
}

if varRead("hit_x") and varRead("hit_y") and varRead("hit_mag") > 0 and varRead("hit_dir") != -99 and net_manager.local_player = id
{
    if instance_exists(hit_indicator)
    {
        if not in_ink(id) and not in_flame(id) and not varRead("fire_counter")
            audio_bullet_hit()
            
        //printf("setting hit vals")
        hit_indicator.alpha += varRead("hit_mag")*HIT_MAG_SCALER
        hit_indicator.dir = varRead("hit_dir")
        if not varRead("fire_counter")
            bloodspray_player(varRead("hit_x"),varRead("hit_y"),varRead("hit_mag")/100,varRead("hit_dir"),varRead("blood_color"))
    } else
    {
        printf("ERROR: no hit indicator")
    }
    
    varWrite("hit_mag",0)
    varWrite("hit_dir",-99)
    varWrite("hit_x",0)
    varWrite("hit_y",0)
}

if initial_weapon_spawn_delay
{
    if is_my_avatar(id)
    {
        initial_weapon_spawn_delay--
        if not initial_weapon_spawn_delay
        {
            printf("spawning weapons")
            //spawn initial weapons
            spawn_my_weapons()
            printf("weapons spawned")
        }
    } else {
        initial_weapon_spawn_delay = 0
    }
}

if recovery_delay_counter
{
    recovery_delay_counter -= real_speed(1)
    
    if recovery_delay_counter < 1
        recovery_delay_counter = 0
        
} else if varRead("hp") < 100
{
    varAdd("hp",100/recovery_time)
    
    if varRead("hp") >= 99
    {
        varWrite("assister","")
        varWrite("killer","")
        obj_update_string(id,"killer",FL_NORMAL)
        obj_update_string(id,"assister",FL_NORMAL)
        varWrite("hp",100)
    }
}

if flash_recovery_delay_counter
{
    flash_recovery_delay_counter -= real_speed(1)
    
    if flash_recovery_delay_counter < 1
        flash_recovery_delay_counter = 0
        
} else if varRead("flash_hp") < 100
{
    varAdd("flash_hp",100/flash_recovery_time)
    
    if varRead("flash_hp") >= 99
    {
        varWrite("assister","")
        obj_update_string(id,"assister",FL_NORMAL)
        varWrite("flash_hp",100)
    }
}

flash_hp_previous = varRead("flash_hp")
hp_previous = varRead("hp")

if die_timer > 0
    die_timer -= real_speed(1)
else
    die_timer = 0

if weapon_wheel_alpha > 0
{
    weapon_wheel_alpha -= weapon_wheel_fader
    
    if weapon_wheel_alpha < 0
    weapon_wheel_alpha = 0
}

if mouse_wheel_delay > 0
    mouse_wheel_delay --

if weapon_contemplating > -1
    weapon_contemplation_time ++
else
    weapon_contemplation_time = 0

if weapon_contemplation_time > weapon_contemplation_time_max
{
    weapon_contemplation_time = 0
    weapon_contemplating = NO_HANDLE
}

/* */
///sync vars
if not varRead("update_ignore_counter")
{
    if not varRead("trigger_update_ignore")
    {
        image_blend = varRead("image_blend")
        image_alpha = varRead("image_alpha")
        
        visible = varRead("visible")
        
        x = varRead("myX")
        y = varRead("myY")
    }
    
    if varRead("trigger_update_ignore")
    {
        varWrite("trigger_update_ignore",false)
        varWrite("update_ignore_counter",varRead("update_ignore_counter_max"))
    }
    
} else {
    if DEBUG
        printf("player #"+varRead("uniqueId")+" ignoring var updates: "+varRead("update_ignore_counter")+" frames left")
    varSub("update_ignore_counter",1)
}

/* */
///death handler --> receive this signal from players that have killed you
if varRead("you_dead_son") and (net_manager.local_player = id or master_of(id))
{
    player_death_handler()
}

/* */
///physics and keyboard control

if PBUG
    pName = varRead("pName")

///basic physics
blahd = in_snare(id)
if blahd and point_distance(x,y,blahd.x,blahd.y) <= point_distance(x+hsp,y,blahd.x,blahd.y)
{
    hsp *= 0.1
}

if varRead("controllable") or (net_manager.starting_match and varRead("myX") > 0 and varRead("myY") > 0) or (objVarRead(net_manager,"end_match_coming") and not position_meeting(x,bbox_bottom+3,solid_generic) and standing_2way = false)
{
    if id = myPlayer() or (not match_starting() and not match_ending())
        scr_basic_physics()
}

if varRead("controllable")
{
    if vsp > -6
        jumping = false
        
    varWrite("sprite_index",sprite_index)
    
    if not is_bot(id)
    {
        update_physics = false
        //THIS IS WHERE SHIT GOES DOWN
        framely_player_controls()
    }
}

/* */
///ARTIFICIAL INTELLIGENCE
if is_bot(id) and not play_dead and not global.map_editor and (not instance_exists(modal_controls) or modal_controls.fade_out) and varRead("controllable") and not net_manager.starting_match and varRead("alive")
{
    var dat_rank = varRead("rank")+1
    var max_rank = global.rank_max_theoretical
    
    //AI override adjustment
    if myPlayer() = id
    {
        dat_rank += 5//15
        if dat_rank > max_rank
            dat_rank = max_rank
    }
    
    if dat_rank < 1
    {
        atarget = 0.025
        rtarget = 0.02
        aamt = 0.8
    }
    else if dat_rank < 5
    {
        atarget = 0.035
        rtarget = 0.03
        aamt = 0.875
    } else if dat_rank < 10
    {
        atarget = 0.05
        rtarget = 0.05
        aamt = 0.875
    } else if dat_rank < 15
    {
        atarget = 0.07
        rtarget = 0.06
        aamt = 0.875
    } else if dat_rank < 20
    {
        atarget = 0.09
        rtarget = 0.08
        aamt = 0.875
    } else {
        atraget = 0.15
        rtarget = 0.1
        aamt = 0.875
    }
    
    var per_active = lerp(dat_rank/max_rank,atarget,aamt)
    var per_reflexes = lerp(dat_rank/max_rank,rtarget,aamt)
    
    ai_retarcus(per_active, per_reflexes)
}

/* */
///sprite and animation control
if (varRead("controllable")) or objVarRead(net_manager,"end_match_coming")
    {
    
    if use_jumping_spr and (collision_rectangle(bbox_left+5,bbox_top+5,bbox_right-5,bbox_bottom+5,block,false,false) or collision_rectangle(bbox_left+5,bbox_top+5,bbox_right-5,bbox_bottom+10,block2_top,false,false))
    {
        use_jumping_spr = false
        varWrite("animation_index",0)
        if not rolling
        {
            animation_stand()
            varWrite("animation_speed",SPD_STAND)
        }
    }
    
    //adjust sprite_index
    if crawling = 1 or rolling = 1 or slide_left = 1 or slide_right = 1
        sprite_index = spr_player_crawl
    else
        sprite_index = spr_player
    
    //don't go too fast crawling
    if (crawling = 1 && rolling = 0 && abs(hsp)>speed_crawl/mass)
    hsp = speed_crawl*sign(hsp)/mass
    
    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+5,block,true,true) || standing_2way = true || floating_2way = true
    if not crawling and not rolling
    {
        if walking
        {animation_walk()}
        else
        {animation_stand() varWrite("animation_speed",SPD_STAND)}
    }
    
    if (slide_left = 0 && slide_right = 0 && rolling = 0)
    if !collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+36,block,true,true) && standing_2way = false && floating_2way = false
    if crawling = 0
    {
        if vsp<18
        {
            if floating_2way = false
            {
                use_jumping_spr = true
                varWrite("animation_index",4) //JUMPING
                varWrite("animation_speed",0)
            }
            else
            {
                animation_walk()
            }
        }
        else
        {
            animation_walk()
        }
    }
    else
    {animation_crawl() varWrite("animation_speed",0)}
    
    //make damn well sure he's crawling
    if sprite_index = spr_player_crawl and varRead("animation") != "crawl" and rolling = 0 and varRead("animation") != "roll" 
    {
        if not in_air or slide_left or slide_right or collision_rectangle(bbox_left,bbox_top-50,bbox_right,bbox_bottom-40,block,true,true)
               
        {
            ///printf("::: FORCING CRAWL")
            animation_crawl()
        }
        else
        {
            ///printf("::: FORCING JUMP")
            animation_walk()
            var ysub = 47
            if not standing_2way and not floating_2way
                ysub = 47
                
            varSub("myY",ysub)
            y = varRead("myY")
            sprite_index = spr_player
            
            x = varRead("myX")
            scr_unstick_guy()
            x = varRead("myX")
            
            if standing_2way or floating_2way
            {
                scr_pull_up(ysub)
            }
        }
    }
    
}

/* */
///wall sliding

/*if slide_left and id = myPlayer()
{
    printf("::: rolling = "+string(rolling)+", crawling = "+string(crawling)+", wall_delay = "+string(wall_delay)+", roll_timer = "+string(roll_timer)+", sprite_index = "+string(sprite_index))
}*/

if (varRead("controllable")) or match_ending()
{
    ///walljumping
    if wall_delay > 0 
    {
        wall_delay = sub_real(wall_delay,1)
    }
    
    if bail_slide_timer
    {
        bail_slide_timer = sub_real(bail_slide_timer,1)
    }
    
    can_slide = true
    
        //first of all, let's bail if you're too close to the ground
        if collision_rectangle(bbox_left+2,bbox_top,bbox_right-2,bbox_bottom+100,block,true,true) || collision_rectangle(bbox_left+2,bbox_bottom,bbox_right-2,bbox_bottom+100,block2_top,true,true)
        {slide_right = 0; slide_left = 0; can_slide = false}
        
        if can_slide
        {
            //don't get stuck on top corners
            if collision_rectangle(bbox_left+4,bbox_top+42,bbox_right+4,bbox_bottom-42,block,true,true) && (collision_rectangle(bbox_left+4,y-10,bbox_right+4,y-9,block,true,true)&&collision_rectangle(bbox_left+4,y+20,bbox_right+4,y+25,block,true,true))
            {
                if not wall_delay
                {
                    if (slide_left = 0)
                    {
                        bail_slide_timer = 0
                        slide_left = 1
                        ID = collision_rectangle(bbox_left+4,bbox_top+42,bbox_right+4,bbox_bottom-42,block,true,true)
                        varWrite("myX",ID.bbox_left-3-sprite_get_width(sprite_index)/2)
                    }
                        
                    hsp = 0
                    
                    if gfric_max != 2
                    {grav = 0.5 if vsp>12 vsp=12}
                    else
                    {if vsp<0 grav=grav_slide else grav=grav_slide if vsp>slide_speed*mass vsp=slide_speed*mass}
                    
                    animation_wall()
                    varWrite("animation_xscale",-1)
                }
            }
            else slide_left = 0
            
            if !collision_rectangle(bbox_left+2,bbox_top,bbox_right-2,bbox_bottom+10,block,true,true)
            if collision_rectangle(bbox_left-4,bbox_top+42,bbox_right-4,bbox_bottom-42,block,true,true) && (collision_rectangle(bbox_left-4,y-10,bbox_right-4,y-9,block,true,true)&&collision_rectangle(bbox_left-4,y+20,bbox_right-4,y+25,block,true,true))
            {
                if not wall_delay
                {   
                    if slide_right = 0
                    {
                        bail_slide_timer =0
                        slide_right = 1
                        ID = collision_rectangle(bbox_left-4,bbox_top+42,bbox_right-4,bbox_bottom-42,block,true,true)
                        varWrite("myX",ID.bbox_right+1+sprite_get_width(sprite_index)/2)
                    }
                    
                    hsp = 0
                    
                    if gfric_max != 2
                    {grav = 0.5 if vsp>12 vsp=12}
                    else
                    {if vsp<0 grav=grav_slide else grav=grav_slide if vsp>slide_speed*mass vsp=slide_speed*mass}
                    
                    animation_wall()
                    varWrite("animation_xscale",1)
                }
            }
            else slide_right = 0
        }
}

/* */
///come out of combat rolls + roll_timer
if roll_timer
{
    roll_timer = sub_real(roll_timer,1)
    
    if slide_left or slide_right
    {
        roll_timer = 0
        rolling = 0
        crawling = 0
        varWrite("animation_speed",0)
        redirect_counter = 0
    }
}
if (varRead("controllable")) or objVarRead(net_manager,"end_match_coming")
{
    if redirect_counter > 0
    {
        redirect_counter = sub_real(redirect_counter,1)
        
        if varRead("speed_multiplier") < 1 and rolling = 1
        {
            hsp *= varRead("speed_multiplier")
        }
        
        if abs(hsp) < 1 and rolling = 1 and not in_snare(id) and varRead("speed_multiplier") > 0.2
        {
            hsp = roll_speed*roll_dir*varRead("speed_multiplier")
        }
        
        if redirect_counter < 1
            {
                if (!collision_rectangle(bbox_left,bbox_top-50,bbox_right,bbox_bottom-40,block,true,true))
                {
                    if (slide_left = 0 && slide_right = 0)
                    {
                        animation_walk()
                        var ysub = 47
                        if not standing_2way and not floating_2way
                            ysub = 47
                            
                        varSub("myY",ysub)
                        y = varRead("myY")
                        sprite_index = spr_player
                        
                        x = varRead("myX")
                        scr_unstick_guy()
                        x = varRead("myX")
                        
                        if standing_2way or floating_2way
                        {
                            scr_pull_up(ysub)
                        }
                    }
                    varWrite("animation_speed",0)
                    rolling = 0
                    crawling = 0
                }
                else
                {
                    if (slide_left = 0 && slide_right = 0)
                    animation_crawl()
                    varWrite("animation_speed",0)
                    crawling = 1
                    rolling = 0
                }
            }
    }
}

/* */
///XY_LERP and pose and animation syncing
//if not varRead("controllable")
{
    if not varRead("controllable") and not match_ending()
        sprite_index = varRead("sprite_index")

    sync_poses_and_animations()
    

    //lerp myX, myY for remote players
    if myPlayer() != id and not is_bot(id)
    {
        if not visible or not varRead("visible") or not varRead("alive") or (x < 0 and y < 0)
            xyLerp_counter = 0
        else
            xyLerp_counter++

        if not match_starting() and not match_ending() and xyLerp_counter > 30
        {
            varWrite("myX",lerp(varRead("myX"),varRead("myX_true"),xyLerp))
            varWrite("myY",lerp(varRead("myY"),varRead("myY_true"),xyLerp))
        } else
        {
            varWrite("myX",varRead("myX_true"))
            varWrite("myY",varRead("myY_true"))
        }
    }
}

/* */
///stop here and lose controllability if end_match_coming
if objVarRead(net_manager,"end_match_coming")
{
    varWrite("controllable",false)
    //varWrite("image_alpha",0.1)
    //varWrite("image_blend",c_blue)
    
    if not slide_right and not slide_left
    {
        varWrite("animation_speed",SPD_STAND)
        animation_stand()
    }
    
    if crawling or rolling
    {
        varSub("myY",35)
        crawling = 0
        rolling = 0
    }
    exit
}

/* */
///stuck detection and correction
if collision_rectangle(bbox_left,bbox_top+2,bbox_right,bbox_bottom-2,block,true,true) and not slide_left and not slide_right
    scr_unstick_guy()

/* */
///process bullet collisions
///only process collision if player is tangible
for (var i=0; i<instance_number(bullet_generic); i++)
{
    datBullet = instance_find(bullet_generic,i)
    
    if instance_place(x,y,datBullet)
    {
        if objVarRead(net_manager,"end_match_coming")
        {
            continue
        }
        if varRead("visible")
        {
            from_player = find_player(objVarRead(datBullet.id,"senderId"))
            if DEBUG
                printf("bullet hit "+varRead("pName")+" ... from "+objVarRead(from_player,"pName"))
            ///only process collision if was a bullet shot from the local player and you are not him
            if objVarRead(datBullet.id,"local") and (
                (net_manager.local_player != id  and not is_local_teammate(id) and not net_manager.bot_match)
                 or (net_manager.bot_match and not are_teammates(id,from_player) and from_player != id)
             )
            {
            
                if not datBullet.id.object_index = splosion_smoke
                audio_bullet_hit()
                
                if DEBUG
                    printf(varRead("pName")+" and "+objVarRead(from_player,"pName")+" are teammates?? = "+are_teammates(id,from_player))
                //if you are not already dying(?)
                if die_timer=0
                {
                    //YOU SIR, HAVE BEEN SHOT
                    
                    killah = from_player
                    if instance_exists(killah) and killah != id
                    {
                        var cand = objVarRead(killah,"pName")
                        if cand != varRead("killer")
                        {
                            varWrite("assister",varRead("killer"))
                            varWrite("killer",cand)
                            obj_update_string(id,"killer",FL_NORMAL)
                            obj_update_string(id,"assister",FL_NORMAL)
                        }
                    } else if killah = id varWrite("killer","")
                    
                    recovery_delay_counter = recovery_delay
                
                    //determine damage falloff
                    shot_range = point_distance(objVarRead(datBullet.id,"myX"),objVarRead(datBullet.id,"myY"),objVarRead(datBullet.id,"xStart"),objVarRead(datBullet.id,"yStart"))
                    var falloff = compute_falloff(datBullet.id,shot_range)
                        
                    is_headshot = bullet_in_head(datBullet.id,objVarRead(datBullet.id,"headshot_difficulty"))
                    
                    if is_headshot
                    {
                        dmg = objVarRead(datBullet.id,"damage_head")*falloff*damage_scaler
                        
                        if shot_range < objVarRead(datBullet.id,"headshot_distance")
                            death_type = "die_headshot"
                        else
                            death_type = objVarRead(datBullet.id,"body_death_type")
                            
                        if SPBUG
                        {
                            printf("ERROR (not): HEADSHOT  ...  damage: "+string(truncate(dmg,2))+"  ...  base: "+string(truncate(dmg/falloff,2))+"  ...  falloff: "+string(truncate(falloff,2)))
                        }
                            
                    }
                    else
                    {
                        dmg = objVarRead(datBullet.id,"damage_body")*falloff*damage_scaler
                        
                        if shot_range < objVarRead(datBullet.id,"gib_distance")
                            death_type = "die_shotgun"
                        else
                            death_type = objVarRead(datBullet.id,"body_death_type")
                            
                        if SPBUG
                        {
                            printf("ERROR (not): BODYSHOT  ...  damage: "+string(truncate(dmg,2))+"  ...  base: "+string(truncate(dmg/falloff,2))+"  ...  falloff: "+string(truncate(falloff,2)))
                        }
                                   
                    }
                    
                    varSub("hp",dmg)
                    
                    obj_sendval_real(id,"hp",dmg,FL_DECREMENT)
                    
                    if not is_bot(id)
                    {
                        if SUPER_DEBUG
                            printf("sending networked hit params")
                        obj_sendval_real(id,"hit_mag",dmg,FL_INCREMENT)
                        obj_sendval_real(id,"hit_dir",objVarRead(datBullet.id,"direction"),FL_NORMAL)
                        obj_sendval_real(id,"hit_x",datBullet.id.x,FL_NORMAL)
                        obj_sendval_real(id,"hit_y",datBullet.id.y,FL_NORMAL)
                        if SUPER_DEBUG
                            printf("sent networked hit params")
                    }
                    
                    if is_bot(from_player) and net_manager.local_player = id
                    {
                        varAdd("hit_mag",dmg)
                        varWrite("hit_dir",objVarRead(datBullet.id,"direction"))
                        varWrite("hit_x",datBullet.id.x)
                        varWrite("hit_y",datBullet.id.y)
                    }
                    
                    if varRead("hp") > 0
                        bloodspray_player(datBullet.id.x,datBullet.id.y,dmg/100,objVarRead(datBullet.id,"direction"),varRead("blood_color"))
                    
                    if varRead("hp") <= 0
                    {
                        //work towards completing a challenge
                        //printf("thinking about invoking challenge_bullet_kill")
                        if not is_bot(from_player)
                        {
                            //printf("invoking challenge_bullet_kill")
                            challenge_bullet_kill(net_manager.local_player, id, datBullet.object_index, death_type)
                        } //else printf("decided against it")
                    
                        //prevent from making multiple kill requests
                        die_timer = 30
                        
                        if not is_bot(from_player)
                        {
                            printf("bullet kill from_player was not a bot --> you get a kill")
                            //increment local player's kills
                            //if not net_manager.bot_match
                                objVarAdd(net_manager.local_player,"kills",1)
                            
                            objVarAdd(net_manager.local_player,"match_kills",1)
                            
                            add_xp(XP_KILL,true,true,false)
                            
                            //send local player's kills to server and datBullet.id clients
                            obj_update_real(net_manager.local_player,"match_kills",FL_NORMAL)
                            stat_update_real("kills",objVarRead(net_manager.local_player,"kills"),stat_manager.stat_flag)
                        }
                        else
                        {
                            printf("awarding a kill to bot: "+objVarRead(from_player,"pName"))
                            objVarAdd(from_player,"kills",1)
                            objVarAdd(from_player,"match_kills",1)
                        }
                        
                        //actually kill the homie
                        kill_player(id,death_type,from_player,objVarRead(datBullet.id,"direction"),FL_NO_FORCE,find_instrument_of_death(datBullet.object_index),"")
                    }
                    
                    
                    //NOW destroy the bullet... not before
                    with datBullet.id {
                        if object_index != splosion_smoke
                        instance_destroy()
                    }
                    
                }
            }
            //destroy the bullet if it was not local and has been around for more than a few frames
            else if datBullet.id.counter > 2 and not are_teammates(id,find_player(objVarRead(datBullet.id,"senderId")))
            {
                with datBullet.id {
                    if DEBUG
                        printf("squashing useless bullet")
                    instance_destroy()
                }
            }
        }
    }
}

/* */
///view stuff

if global.using_gamepad or not computed_curs
compute_cursor_offset()

if global.using_gamepad //or not computed_view
framely_view_adjust()

/* */
/*  */
