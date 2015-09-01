///kill_player(player_obj,death_type,killer,hit_dir,hit_force,instrument_of_death,acc_autocomplete)
var dead_homes = argument0
var death_type = argument1
var killer = argument2
var hit_dir = argument3
var hit_force = argument4
var instrument_of_death = argument5
var acc_autocomplete = argument6

var killer_name = string(objVarRead(killer,"pName"))
var deadguy_name = string(objVarRead(dead_homes,"pName"))
if not net_manager.bot_match
{
    sendBigMessageStrReal2("kill_feed",killer_name,deadguy_name,real(instrument_of_death))
}
new_kill_feed_message(killer_name,deadguy_name,real(instrument_of_death))

if objVarRead(net_manager,"end_match_coming")
{
    printf("NOTICE: can't kill player -- end match coming")
    return false
}

if instrument_of_death = spr_none
{
    printf(":::WARNING: kill_player passed unknown instrument of death")
}
else
{
    //get force for this instrument of death when dying normally
    if death_type != "die_headshot" and death_type != "die_splosion" and death_type != "die_shotgun"
    {
        hit_force = weapon_spr_hitforce(instrument_of_death)
    }
}

point_total = POINTS_KILL
if death_type = "die_headshot"
    point_total += POINTS_HEADSHOT
if death_type = "die_splosion" or death_type = "die_shotgun"
    point_total += POINTS_GIB

if killer = net_manager.local_player or net_manager.bot_match
{
    objVarAdd(killer,"match_points",point_total)
    objVarAdd(killer,"points",point_total)
}

if dead_homes != net_manager.local_player and killer = net_manager.local_player
{
    //YOU KILLED HIM
    
    refresh_scoregrid()
    
    audio_play_sound(snd_kill,1,false)
    delay_spacer = 2
    boom_delay = compute_boom_delay()
    boom_group = random_range(0,1000000)
    boom_scale = 0.75
    
    if instrument_of_death != spr_none
    {
        //update permanent kill totals for this weapon
        var spr = sprite_get_name(instrument_of_death)
        var curr_val = acc_total(spr)
        printf(":::updating permanent kill total for weapon: "+string(spr))
        update_accolade_total(spr,curr_val+1,stat_manager.stat_flag,true)
    }
    
    //for stick kills and such
    if acc_autocomplete != ""
        complete_accolade(acc_autocomplete)
    
    //UPDATE POINTS IN DB
    stat_update_real("points",objVarRead(killer,"points"),stat_manager.stat_flag)
    
    //UPDATE KILL_STREAK POTENTIALLY
    challenge_manager.spree_deaths = 0
    
    spree = challenge_manager.spree_kills
    spree += max(0,varRead("rollover_kstreak"))
    
    if spree > varRead("kill_streak")
        stat_update_real("kill_streak",spree,stat_manager.stat_flag)
    
    switch(death_type)
    {
        case "die_headshot":
            with challenge_manager
            {
                spree_headshots ++
                if spree_headshots = 3 complete_accolade("3heads") else if spree_headshots = 6 complete_accolade("6heads")
                else if spree_headshots = 9 complete_accolade("9heads") else if spree_headshots = 12 complete_accolade("12heads")
            }
            
            ID = boom_boom_pow("+"+string(POINTS_HEADSHOT)+" Headshot",global.action_word_color)
            ID.fnt = fnt_boom
            ID.extra_delay = boom_delay
            ID.birth_delay = 1
            ID.group_id = boom_group
            ID.draw_y -= ID.vsep*2
            ID.scale = boom_scale
            boom_delay += delay_spacer/2
            //varAdd("match_points",POINTS_HEADSHOT)
        break
        
        case "die_splosion":
            with challenge_manager
            {
                spree_gibs ++
                if spree_gibs = 3 complete_accolade("3gibs") else if spree_gibs = 6 complete_accolade("6gibs")
                else if spree_gibs = 9 complete_accolade("9gibs") else if spree_gibs = 12 complete_accolade("12gibs")
            }
            var dismem = global.dismembered
            if not truthval(global.gc[GC_VIOLENT_CONTENT,1])
                dismem = global.dismembered_tame
            ID = boom_boom_pow("+"+string(POINTS_GIB)+" "+dismem,global.action_word_color)
            ID.fnt = fnt_boom
            ID.extra_delay = boom_delay
            ID.birth_delay = 1
            ID.group_id = boom_group
            ID.draw_y -= ID.vsep*2
            ID.scale = boom_scale
            boom_delay += delay_spacer/2
            //varAdd("match_points",POINTS_GIB)
        break
        
        case "die_shotgun":
            with challenge_manager
            {
                spree_gibs ++
                if spree_gibs = 3 complete_accolade("3gibs") else if spree_gibs = 6 complete_accolade("6gibs")
                else if spree_gibs = 9 complete_accolade("9gibs") else if spree_gibs = 12 complete_accolade("12gibs")
            }
            var dismem = global.dismembered
            if not truthval(global.gc[GC_VIOLENT_CONTENT,1])
                dismem = global.dismembered_tame
            ID = boom_boom_pow("+"+string(POINTS_GIB)+" "+dismem,global.action_word_color)
            ID.fnt = fnt_boom
            ID.extra_delay = boom_delay
            ID.birth_delay = 1
            ID.group_id = boom_group
            ID.draw_y -= ID.vsep*2
            ID.scale = boom_scale
            boom_delay += delay_spacer/2
            //varAdd("match_points",POINTS_GIB)
        break
    }
    
    //award points
    ID = boom_boom_pow("+"+string(POINTS_KILL)+" Kill",global.action_word_color)
    ID.fnt = fnt_boom
    ID.scale = boom_scale
    ID.extra_delay = boom_delay
    ID.birth_delay = 1
    ID.group_id = boom_group
    ID.draw_y -= ID.vsep
    boom_delay += delay_spacer
    
    ID = boom_boom_pow("+"+string(point_total)+"",global.boom_total_color)
    ID.fnt = fnt_boom
    ID.scale = 2
    ID.extra_delay = boom_delay
    ID.birth_delay = 1
    ID.group_id = boom_group
    
    //keep track of kills for challenges
    with challenge_manager {
        string_kills ++
        string_counter = string_counter_max
        match_kills ++
        spree_kills ++
        
        if ninja_time > 0
            untouched_kills ++
            
        //can't touch dis
        if untouched_kills >= acc_data("cant_touch_dis",COL_NEEDED)
        {
            complete_accolade("cant_touch_dis")
            untouched_kills = 0
        }
        
        //kill streak accolades
        if spree_kills = 3 complete_accolade("3ks") else if spree_kills = 5 complete_accolade("5ks")
        else if spree_kills = 10 complete_accolade("10ks") else if spree_kills = 15 complete_accolade("15ks")
        else if spree_kills = 20 complete_accolade("20ks") else if spree_kills = 25 complete_accolade("25ks")
        else if spree_kills > 25 spree_kills = 0
        
        //dub/trip kills
        if string_kills = 2 complete_accolade("dub_kill")
        else if string_kills = 3 complete_accolade("trip_kill")
        else if string_kills > 3 string_kills = 0
        
        /*if spree_kills >= assassin_spree_needed and not challenge_is_complete(global.ass_name)
            complete_challenge(global.ass_name)
        
        if spree_kills >= bhunch_kills and not challenge_is_complete("Hell Hound")
            complete_challenge("Hell Hound")
            
        if spree_kills >= smallvisor2_kills and not challenge_is_complete(global.smallvisor2_name)
            complete_challenge(global.smallvisor2_name)
            
        if spree_kills >= samurai_kills and not challenge_is_complete(global.samurai_name)
            complete_challenge(global.samurai_name)
            
        if match_kills >= ahunch_kills and not challenge_is_complete("War Mongrel")
            complete_challenge("War Mongrel")
            
        if string_kills >= hound_kills and not challenge_is_complete("Hound Helmet")
            complete_challenge("Hound Helmet")
            
        if string_kills >= fanatic_kills and not challenge_is_complete("Fanatic Helmet")
            complete_challenge("Fanatic Helmet")*/
    }
}

ass_cand = objVarRead(dead_homes,"assister")
kill_cand = objVarRead(dead_homes,"killer")
if kill_cand != ass_cand and ass_cand != "" and killer != dead_homes
{
    //tell that player to get an assist
    var ass = find_player_by_pname(ass_cand)
    if net_manager.bot_match
        objVarAdd(ass,"get_assist",1)
    else
        obj_sendval_real(ass,"get_assist",1,FL_INCREMENT)
        
    printf("TELLING "+objVarRead(ass,"pName")+" to get an assist")
}

//get the dead homes out of the way
objVarWrite(dead_homes,"visible",false)
//objVarWrite(dead_homes,"controllable",false)
objVarWrite(dead_homes,"drop_weapon_x",objVarRead(dead_homes,"myX"))
objVarWrite(dead_homes,"drop_weapon_y",objVarRead(dead_homes,"myY"))

objVarWrite(dead_homes,"myX",-50)
objVarWrite(dead_homes,"myY",-50)
dead_homes.x = -50
dead_homes.y = -50
dead_homes.visible = false
objVarWrite(dead_homes,"you_dead_son",true)

//prevent the remote homie from overriding these updates (before he realizes he's dead)
objVarWrite(dead_homes,"trigger_update_ignore",true)

pkgCreate()
obj_update_real(dead_homes,"visible",FL_NORMAL)
//obj_update_real(dead_homes,"controllable",FL_NORMAL)
obj_update_real(dead_homes,"myX",FL_NORMAL)
obj_update_real(dead_homes,"myY",FL_NORMAL)
obj_update_real(dead_homes,"drop_weapon_x",FL_NORMAL)
obj_update_real(dead_homes,"drop_weapon_y",FL_NORMAL)
obj_update_real(dead_homes,"you_dead_son",FL_NORMAL)
obj_update_real(dead_homes,"trigger_update_ignore",FL_NORMAL)
pkgSend()

//create the dead player object
uDead = instance_create_for_everyone(objVarRead(dead_homes,"drop_weapon_x"),objVarRead(dead_homes,"drop_weapon_y"),die_generic)

str_vars[0] = "helmet0"
str_vars[1] = "torso0"
str_vars[2] = "leg0"
str_vars[3] = "shin0"
str_vars[4] = "hat0"
str_vars[5] = "shoulder0"
str_vars[6] = "forearm0"
str_vars[7] = "foot0"

for (var k=0; k<8; k++)
{
    objVarWrite(uDead,str_vars[k],objVarRead(dead_homes,str_vars[k]))
    obj_update_real(uDead,str_vars[k],FL_NORMAL)
}

//select the right death animation
switch(death_type)
{
    case "die_headshot":
        if DEBUG
            printf("player # "+objVarRead(dead_homes,"uniqueId")+" dead ----> HEADSHOT")
        objVarWrite(uDead,"die_headshot",true)
    break
    
    case "die_splosion":
        if DEBUG
            printf("player # "+objVarRead(dead_homes,"uniqueId")+" dead ----> GIB")
        objVarWrite(uDead,"die_splosion",true)
    break
    
    case "die_shotgun":
        objVarWrite(uDead,"die_shotgun",true)
    break
    
    default:
        if DEBUG
            printf("player # "+objVarRead(dead_homes,"uniqueId")+" dead ----> DO A FLIP")
        objVarWrite(uDead,"die",true)
    break

}

    if objVarRead(dead_homes,"fire_counter")
    {
        objVarWrite(uDead,"fire_counter",objVarRead(uDead,"fire_counter_max")/2)
    }

    if object_index = splosion_flame_instant
    {
        objVarWrite(uDead,"fire_counter",objVarRead(uDead,"fire_counter_max"))
    }   

    objVarWrite(dead_homes,"killer",objVarRead(killer,"pName"))
    objVarWrite(uDead,"pName",objVarRead(dead_homes,"pName"))
    objVarWrite(uDead,"animation_xscale",objVarRead(dead_homes,"animation_xscale"))
    objVarWrite(uDead,"forearm0",objVarRead(dead_homes,"forearm0"))
    objVarWrite(uDead,"shoulder0",objVarRead(dead_homes,"shoulder0"))
    objVarWrite(uDead,"leg0",objVarRead(dead_homes,"leg0"))
    objVarWrite(uDead,"shin0",objVarRead(dead_homes,"shin0"))
    objVarWrite(uDead,"foot0",objVarRead(dead_homes,"foot0"))
    objVarWrite(uDead,"torso0",objVarRead(dead_homes,"torso0"))
    objVarWrite(uDead,"head0",objVarRead(dead_homes,"head0"))
    objVarWrite(uDead,"hat0",objVarRead(dead_homes,"hat0"))
    objVarWrite(uDead,"hit_dir",hit_dir)
    objVarWrite(uDead,"hit_force",hit_force)
    objVarWrite(uDead,"can_die",true)
    objVarWrite(uDead,"blood_color",objVarRead(dead_homes,"blood_color"))
    
    pkgCreate()
    obj_update_string(dead_homes,"killer",FL_NORMAL)
    obj_update_string(uDead,"pName",FL_NORMAL)
    obj_update_real(uDead,"blood_color",0)
    obj_update_real(uDead,"can_die",FL_NORMAL)
    obj_update_real(uDead,"die",0)
    obj_update_real(uDead,"hit_dir",0)
    obj_update_real(uDead,"hit_force",0)
    obj_update_real(uDead,"die_headshot",0)
    obj_update_real(uDead,"die_splosion",0)
    obj_update_real(uDead,"die_shotgun",0)
    obj_update_real(uDead,"animation_xscale",0)
    obj_update_real(uDead,"forearm0",0)
    obj_update_real(uDead,"shoulder0",0)
    obj_update_real(uDead,"leg0",0)
    obj_update_real(uDead,"shin0",0)
    obj_update_real(uDead,"foot0",0)
    obj_update_real(uDead,"torso0",0)
    obj_update_real(uDead,"head0",0)
    obj_update_real(uDead,"hat0",0)
    obj_update_real(uDead,"fire_counter",FL_NORMAL)
    pkgSend()
