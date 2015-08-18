///damage_splosion()
if objVarRead(net_manager,"end_match_coming") return false

var kill_force = FL_NO_FORCE
var acc_autocomplete = ""

if is_stick_kill
    acc_autocomplete = "stick_kill"
    
if object_index = splosion_ink
    acc_autocomplete = "ink_kill"
else if object_index = splosion_flame or object_index = splosion_flame_instant
    acc_autocomplete = "flame_kill"

{
        //if DEBUG
           // printf("analyzing splodable player: "+objVarRead(dat_playa,"uniqueId"))
            
        //determine if the player is hit
        try_x[0] = dat_playa.x
        try_y[0] = dat_playa.y
        try_x[1] = dat_playa.x
        try_y[1] = dat_playa.bbox_top+1
        try_x[2] = dat_playa.x
        try_y[2] = dat_playa.bbox_bottom-1
        shot_ranges[0] = room_width
        shot_ranges[1] = room_width
        shot_ranges[2] = room_width
        
        var shot_range = room_width
        
        for (var j=0; j<3; j++)
        {
            if not collision_line(x,y,try_x[j],try_y[j],solid_generic,true,false)
            {
                shot_ranges[j] = point_distance(x,y,try_x[j],try_y[j])
            }
        }
        
        shot_range = min(shot_ranges[0],shot_ranges[1],shot_ranges[2])
        
        if  (dat_playa = from_player or not are_teammates(dat_playa,from_player)) and (shot_range < radius or object_index = splosion_ink or object_index = splosion_snare or object_index = splosion_flame)//damage radius defined in create
        {
            //player is hit!!      
            dat_playa.recovery_delay_counter = dat_playa.recovery_delay
            var falloff = compute_falloff(id,shot_range)
            
            var killah = from_player//find_player(varRead("senderId"))
            if instance_exists(killah) and killah != dat_playa
            {
                var cand = objVarRead(killah,"pName")
                if cand != objVarRead(dat_playa,"killer")
                {
                    if dat_playa != from_player
                        objVarWrite(dat_playa,"assister",objVarRead(dat_playa,"killer")) 
                    objVarWrite(dat_playa,"killer",cand)
                    obj_update_string(dat_playa,"killer",FL_NORMAL)
                    obj_update_string(dat_playa,"assister",FL_NORMAL)
                }
            } else
            {
                if killah = dat_playa
                    objVarWrite(dat_playa,"killer","")
                if not instance_exists(killah)
                 printf("ERROR: no splosion senderId")
            }
            
            //if DEBUG
            {
               // printf("SPLOSION HIT ----> falloff scaler: "+falloff)
            }
            
            var dmg = damage*falloff*player.damage_scaler
             
            if object_index = splosion_ink
            {
                //don't go flying
                kill_force = 0
                
                dmg = real_speed(damage*player.damage_scaler)
            }
            
            if object_index = splosion_flame
            {
                //don't go flying
                kill_force = 0
                
                if in_my_flame(dat_playa)
                {
                    //in flame damage
                    dmg = real_speed(damage*player.damage_scaler)
                    objVarAdd(dat_playa,"fire_counter",7)
                    obj_update_real(dat_playa,"fire_counter",FL_NORMAL)
                }
                else
                {
                    //burning damage
                    dmg = damage_burning*player.damage_scaler
                }
            }
            
            if object_index = splosion_flashbang
            {
                if not is_local_teammate(dat_playa) and dmg > 50 and from_player = myPlayer() and dat_playa != myPlayer()
                {   
                    //award points for flash
                    award_points = ceil(POINTS_FLASH*dmg/100)
                    ID = boom_boom_pow("+"+string(award_points)+" Stun",global.action_word_color)
                    ID.fnt = fnt_boom
                    ID.birth_delay = 2
                    ID.draw_y -= ID.vsep*2
                    ID.scale = 1
                    
                    //update flash totals
                    increment_weapon_accolade("spr_flashbang")
            
                    //award xp for flash
                    award_xp = ceil(XP_FLASH*dmg/100)
                    add_xp(award_xp,true,true,false)
                    
                    with challenge_manager
                    {
                        spree_flashes++
                        flashes++
                        if spree_flashes >= acc_data("flash_bandicoot",COL_NEEDED)
                        {
                            spree_flashes = 0
                            complete_accolade("flash_bandicoot")
                        }
                    }
                }
                
                
                objVarSub(dat_playa,"flash_hp",dmg)
                obj_sendval_real(dat_playa,"flash_hp",dmg,FL_DECREMENT)
            }
            else
            {
                if shot_range < varRead("gib_distance")
                {
                    var death_type = "die_splosion"
                }
                else
                {
                    var death_type = varRead("body_death_type")
                    if kill_force != FL_NO_FORCE
                        kill_force = random_range(FORCE_SPLOSION-1,FORCE_SPLOSION+1)
                }
                    
                objVarSub(dat_playa,"hp",dmg)
                obj_sendval_real(dat_playa,"hp",dmg,FL_DECREMENT)
                
                hit_dir = point_direction(x,y,dat_playa.x,dat_playa.y)
                
                objVarWrite(dat_playa,"hit_x",dat_playa.x)
                obj_sendval_real(dat_playa,"hit_x",dat_playa.x, FL_NORMAL)
                objVarWrite(dat_playa,"hit_y",dat_playa.y)
                obj_sendval_real(dat_playa,"hit_y",dat_playa.y, FL_NORMAL)
                
                objVarWrite(dat_playa,"hit_dir",hit_dir)
                obj_sendval_real(dat_playa,"hit_dir",hit_dir, FL_NORMAL)
                objVarWrite(dat_playa,"hit_mag",dmg*1.5)
                obj_sendval_real(dat_playa,"hit_mag",dmg*1.5, FL_INCREMENT)
                
                //bloodspray_player(dat_playa.x,dat_playa.y,dmg/50,hit_dir)
                
                if objVarRead(dat_playa,"hp") <= 0
                {
                    if object_index = splosion_ink
                    {
                        if dat_playa != net_manager.local_player and from_player = net_manager.local_player
                            challenge_manager.ink_kills ++
                    }
                    
                    if object_index = splosion_thumper
                    {
                        if dat_playa != net_manager.local_player and from_player = net_manager.local_player
                            challenge_manager.thumper_kills ++
                    }
                    
                    if object_index = splosion_flame_instant
                    {
                        if dat_playa != net_manager.local_player and from_player = net_manager.local_player
                            challenge_manager.flame_kills ++
                    }
                
                    if not is_bot(from_player) and dat_playa != net_manager.local_player and from_player = net_manager.local_player
                    {
                        challenge_bullet_kill(net_manager.local_player,dat_playa,object_index,death_type)
                        
                        if object_index = splosion_frag
                        {
                            challenge_manager.frag_kills++
                            
                           /* if challenge_manager.frag_kills >= challenge_manager.frag_kills_needed
                                with challenge_manager
                                {
                                    if not challenge_is_complete(global.frag)
                                        complete_challenge(global.frag)
                                }*/
                        }
                    }
                    
                    //prevent from making multiple kill requests
                    dat_playa.die_timer = 30
                    
                    //increment local player's kills
                    if dat_playa != net_manager.local_player and from_player = net_manager.local_player
                    {
                        objVarAdd(net_manager.local_player,"kills",1)
                        objVarAdd(net_manager.local_player,"match_kills",1)
                        
                        add_xp(XP_KILL,true,true,false)
                        
                        //increment local player's kills
                        obj_update_real(net_manager.local_player,"match_kills",FL_NORMAL)
                        stat_update_real("kills",objVarRead(net_manager.local_player,"kills"),stat_manager.stat_flag)   
                        
                        //tell whatever player this is to die on his machine
                        if object_index = splosion_ink or object_index = splosion_flame
                            kill_force = 0
                            
                        kill_player(dat_playa,death_type, from_player,hit_dir,kill_force,find_instrument_of_death(object_index),acc_autocomplete)
                    }
                    else
                    {
                        if is_bot(from_player) and from_player != dat_playa
                        {
                            objVarAdd(from_player,"kills",1)
                            objVarAdd(from_player,"match_kills",1)
                        } else if not is_bot(from_player)
                        {
                            //player killed himid
                            if objVarRead(net_manager.local_player,"match_kills") > 0
                            {
                                objVarSub(net_manager.local_player,"kills",1)
                                objVarSub(net_manager.local_player,"match_kills",1)
                                obj_update_real(net_manager.local_player,"match_kills",FL_NORMAL)
                                stat_update_real("kills",objVarRead(net_manager.local_player,"kills"),stat_manager.stat_flag) 
                            }  
                        } else
                        {
                            //bot killed himid
                            if objVarRead(from_player,"match_kills") > 0
                            {
                                objVarSub(from_player,"kills",1)
                                objVarSub(from_player,"match_kills",1)
                            }
                        }
                        
                        //player killed himid or a bot killed him
                        if object_index = splosion_ink or object_index = splosion_flame
                            kill_force = 0
                            
                        kill_player(dat_playa, death_type, from_player,hit_dir,kill_force,find_instrument_of_death(object_index),acc_autocomplete)
                    }
                }
            }
        }
    
    }
