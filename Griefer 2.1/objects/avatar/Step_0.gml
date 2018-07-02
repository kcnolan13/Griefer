/// @description pNum_override

/*if spam_pnum
{
    spam_pnum --
    printf("::: SPAM -- "+string(varRead("pName"))+"'s avatar has pNum="+string(varRead("pNum"))+", override="+string(varRead("pNum_override")))
}
*/
if varRead("pNum_override") > -1
{
    if varRead("pNum") != varRead("pNum_override")
    {
        printf("::: "+varRead("pName")+"'s Avatar is overwriting pNum: "+string(varRead("pNum"))+" ---> "+string(varRead("pNum_override")))
        varWrite("pNum",varRead("pNum_override"))
    }
}
/*
if keyboard_check_pressed(vk_enter)
{
    printf("::: "+varRead("pName")+"'s avatar has pNum "+string(varRead("pNum")))
}*/

/* */
///shuffling
if shuffling //and x > 0 and x < room_width
{
    //printf("::: shuffling = "+string(shuffling))
    shuffling = sub_real(shuffling,1)
    
    event_perform(ev_alarm,2)
    alarm[2] = 5
    
    image_alpha = 0.35
    
    if not shuffling
    {    
        image_alpha = 1
        //play swoosh in sound?
    }
    
    //scale down while shuffling
    varWrite("animation_scale",lerp_real(varRead("animation_scale"),2.15,1))
    
    var shuffle_frames = ceil(lerp_real(0.05,3,(shuffling_max-shuffling)/shuffling_max))
    
    if shuffle_frames = 0
        shuffle_frames = 1
        
    //shuffle name and gear and rank and whatnot
    if nth_frame(2)
    {
        var avg_rank = floor(global.num_ranks/2)
        var num_bots = instance_number(avatar) -1
        var points = floor(random_range(avg_rank*num_bots*2/3,avg_rank*num_bots*3/2))

        //select name and rank
        var name = string(generate_name(0.01))
    
        if not instance_exists(myAvatar())
        {
            printf("ERROR: cannot shuffle in avatar step --> no myAvatar() to cross-check name hashes with")
            return false
        }
    
        var rank = net_manager.bot_diff_level //objVarRead(myAvatar(),"rank")
        
        if num_bots != 1
        {
            rank += floor(random_range(-1,2))
        }
        
        rank = constrict(rank,0,getLength(global.rank_names)-1)
            
        if hash_string(name) = objVarRead(myAvatar(),"uniqueId")
        {
            while (hash_string(name) = objVarRead(myAvatar(),"uniqueId"))
            {
                name = string(generate_name(0.01))
            }
        }
            
        points -= rank
        global_rank = 99999

        varWrite("uniqueId",hash_string(name))
        varWrite("pName",name)
        varWrite("rank",rank)
        varWrite("global_rank",global_rank)
    
        same_armor_probability = random_range(0,1.5)
        armor_set = armor_set_diceroll(rank)
    
        //select some gear for the bot to wear
        for (var j=0; j<array_length_1d(global.bpart_limb_types); j++)
        {
            var new_limb
            
            if j=4 and random(1) > 0.25+rank/global.rank_max_theoretical
                new_limb = spr_hat
            else
            {
            
                var sameprob = same_armor_probability
                if j=0
                    sameprob = sameprob/6
            
                if random(1) < sameprob and j < 8
                    new_limb = armor_set_limb(armor_set,global.bpart_limb_types[j]) 
                else
                    new_limb = random_diceroll_limbtype(global.bpart_limb_types[j])
            }
            
            varWrite(global.bpart_limb_types[j]+"0",new_limb)
        }
    
    }
}

/* */
///quit handling.... and more now

varWrite("pName",string(varRead("pName")))
if room = rm_lobby
{
    if nth_frame(10)
        printf(string(varRead("pName"))+"'s uID: "+string(varRead("uniqueId")))
}
if instance_exists(net_manager.my_doll) and net_manager.my_doll != id and string(varRead("pName")) = string(objVarRead(net_manager,"pName")) and room = rm_lobby
{
    printf("DUPLICATE DOLL DETECTED")
    /*if net_manager.room_counter > 30*3
    {
        printf("DUPLICATE DOLL DESTROYED")
        instance_destroy()
        exit
    }*/
}

if net_manager.menu_mode = "lottery_steal" and not is_my_avatar(id)
{
    x = room_width*10
    y = room_width*10
}

if net_manager.my_doll = id
{
    /*printf("player_quit = "+varRead("player_quit"))
    printf("visible = "+visible)
    printf("myX = "+varRead("myX"))
    printf("myY = "+varRead("myY"))*/
} 
  
if varRead("player_quit")
{
    printf(":::DESTROYING AVATAR WHO QUIT: "+varRead("pName"))
    instance_destroy()
    exit
    
    x = -600
    y = -600
    visible = false
    varWrite("myX",-600)
    varWrite("myY",-600)
    varWrite("visible",false)
    
    if (in_match() or room = rm_menu)
    {
        with player
        {
            if playerName(id) = playerName(other.id)
            {
                x = -2000
                y = -2000
                varWrite("myX",-2000)
                varWrite("myY",-2000)
                visible = false
            }
        }
        printf("DESTROYING PLAYER WHO QUIT: "+varRead("pName"))
        instance_destroy()
        exit
    }
}

/* */
///all dat ish

if real(varRead("hat0")) = spr_head or real(varRead("foot0")) = spr_head or real(varRead("shin0")) = spr_head
{
    if not asked_force_sync and room = rm_lobby and dummy_counter > 5
    {
        asked_force_sync = true
        printf("::: "+varRead("pName")+"'s avatars is messed up ... requesting force-sync")
        sendMessageReal("force_sync_doll",1)

        //write default limb vals as placeholders until the real data comes in
        varWrite("helmet0",spr_head)
        varWrite("torso0",spr_torso)
        varWrite("leg0",spr_leg)
        varWrite("shin0",spr_shin)
        varWrite("foot0",spr_foot)
        varWrite("hat0",spr_hat)
        varWrite("shoulder0",spr_shoulder)
        varWrite("forearm0",spr_forearm)
        varWrite("prop0",spr_prop_none)
    }
}

if mouse_wheel_delay > 0
mouse_wheel_delay --

//talk sometimes
if is_bot(id)
{
    if random(1) < 1/(30*120)
    {
        //new_chat_feed_message(varRead("pName"),"","Are you sucking my cock or is it just me?")
    }
}

if is_bot(id) or ( id = myAvatar() and net_manager.bot_override )
{
    if not in_match() and not varRead("ready") and not shuffling
        {
            varWrite("ready",true)
            if instance_exists(bound_bn_ready)
            {
                bound_bn_ready.ready = true
            } else {
                printf("ERROR: bound_bn_ready doesn't exist (avatar step event)")
            }
        }
}

if in_match()
{
    x = room_width+400
    y = -400
}

if room = rm_menu and net_manager.my_doll != id
{
    x = room_width+400
    y = -400
}

/*printf("hat0 = "+varRead("hat0"))
printf("y = "+y)
printf("x = "+x)
printf("pName="+varRead("pName"))
printf("visible="+visible)
printf("helmet0="+varRead("helmet0"))
printf("leg0="+varRead("leg0"))*/

if ( room = rm_menu or room = rm_lobby) and visible = false and net_manager.room_counter > 30*1
{
    varWrite("visible",true)
    visible = true
}

//sync match stats with local players
if not is_bot(id) and instance_exists(net_manager.local_player) and in_match() and net_manager.room_counter > 30*2 and varRead("pName") = objVarRead(net_manager,"pName")
{
    varWrite("match_points",objVarRead(net_manager.local_player,"match_points"))
    varWrite("match_kills",objVarRead(net_manager.local_player,"match_kills"))
    varWrite("match_deaths",objVarRead(net_manager.local_player,"match_deaths"))
    varWrite("match_assists",objVarRead(net_manager.local_player,"match_assists"))
    //send these at 2 Hz, no need for 30 Hz
    if nth_frame(15)
    {
        obj_update_real(id,"match_points",FL_NORMAL)
        obj_update_real(id,"match_kills",FL_NORMAL)
        obj_update_real(id,"match_deaths",FL_NORMAL)
        obj_update_real(id,"match_assists",FL_NORMAL)
        //obj_update_real(id,"match_rank",FL_NORMAL)
    }
    varWrite("points",objVarRead(net_manager.local_player,"points"))
    varWrite("kills",objVarRead(net_manager.local_player,"kills"))
    varWrite("deaths",objVarRead(net_manager.local_player,"deaths"))
}

if is_bot(id) and instance_exists(my_bot) and in_match() and net_manager.room_counter > 30*2
{
    syncVarFrom(my_bot,"match_points")
    syncVarFrom(my_bot,"match_kills")
    syncVarFrom(my_bot,"match_deaths")
    syncVarFrom(my_bot,"match_assists")
    syncVarFrom(my_bot,"kills")
    syncVarFrom(my_bot,"deaths")
    syncVarFrom(my_bot,"points")
}

//NO LOITERING!!
if room = rm_menu and id != net_manager.my_doll
{
    if (net_manager.room_counter > 30*3 or net_manager.previous_room = rm_lobby or net_manager.came_from_match) and not waiting_for_data()
    {
        
        printf("destroying avatar for loitering")
        printf("avatar's pName: "+string(varRead("pName"))+", net_man's pName: "+string(objVarRead(net_manager,"pName")))
        instance_destroy()
        exit
    } else 
    {
        x = room_width*4
        y = room_height*4
    }  
}

//STEAL OR LOSE GEAR (HANDLERS FOR LOCAL PLAYER ONLY)
/*
if id != net_manager.my_doll
{
    if varRead("gear_to_lose")
    {
        lose_gear(varRead("gear_to_lose"))
    }
    
    if varRead("gear_to_steal") and varRead("stolen_gear_source") != global.src_empty
    {
        steal_gear(varRead("gear_to_steal"), varRead("stolen_gear_source"))
    }
}*/

if is_bot(id) and room = rm_lobby
{
    if varRead("prop0") = spr_none
        pose_pistol()
        
    if varRead("gear_to_lose")
    {
        bot_lose_gear(varRead("gear_to_lose"))
    }
    
    if varRead("gear_to_steal") and varRead("stolen_gear_source") != global.src_empty
    {
        bot_steal_gear(varRead("gear_to_steal"))
    }

}

varWrite("animation_speed",SPD_STAND)

if not bparts_ready[0]
{
    for (var i=0; i<1; i++)
    {
        if not bparts_ready[i] and room != rm_login
        {
            bparts_ready[i] = bparts_get_ready(i)
        }
    }
}

if rtime() < 30
    with net_manager
    {
        if other.id != my_doll
        {
            if other.id.x < room_width/2
            {
                objVarWrite(other.id,"rot_true",345)
                objVarWrite(other.id,"animation_xscale",1)
            }
            else
            {
                objVarWrite(other.id,"rot_true",195)
                objVarWrite(other.id,"animation_xscale",-1)
            }
        }
    }

if room = rm_lobby and net_manager.room_counter > 30
{
    if myAvatar() = id
    {
        //sync uniqueID with netMan's
            //varWrite("uniqueId",objVarRead(net_manager,"uniqueId"))

        obj_pname_update_real(id,"rot_true",FL_NORMAL)
        if nth_frame(3) obj_pname_update_real(id,"active_weapon_sprite",FL_NORMAL)
        //obj_pname_update_real(id,"animation_speed",FL_NORMAL)
        //obj_pname_update_real(id,"arm_animation_speed",FL_NORMAL)
        //obj_pname_update_real(id,"animation_index",FL_NORMAL)
        if nth_frame(3) obj_pname_update_real(id,"active_weapon_prescaler",FL_NORMAL)
        if nth_frame(1) obj_pname_update_real(id,"animation_xscale",FL_NORMAL)
        if nth_frame(3) obj_pname_update_string(id,"arm_pose",FL_NORMAL)
        if nth_frame(30) obj_pname_update_real(id,"true_skill",FL_NORMAL)
        if nth_frame(30) obj_pname_update_real(id,"global_rank",FL_NORMAL)
    }

}

if room = rm_menu or room = rm_lobby
{
    varWrite("arm_animation_speed",0)
    varWrite("arm_animation_index",0)
    sync_poses_and_animations()
}

if room = rm_lobby and force_jumped = false and varRead("uniqueId") != "-52"
{
    force_jumped = true
    with net_manager
    {
        av_padding = room_width/instance_number(avatar)
        //get the instance number of this player
        for (var i=0; i<instance_number(avatar); i++)
        {
            temp = instance_find(avatar,i)
            if temp = other.id
                break
        }
        other.id.x = av_padding*(objVarRead(temp,"pNum")+0.5)
        other.id.y = 0
    }
}


//INHERITED EVENT, OF COURSE
event_inherited()

/* */
///sync prop with active_weapon_sprite and arm_pose
if real(varRead("prop0")) > 0 and room = rm_menu or room = rm_lobby
{
    varWrite("active_weapon_sprite",varRead("prop0"))
    
    switch real(varRead("prop0"))
    {
        case spr_prop_none:
            varWrite("arm_pose",global.pistol_pose)
            varWrite("active_weapon_prescaler",global.pistol_scale)
        break
        
        case spr_prop:
            varWrite("arm_pose",global.pistol_pose)
            varWrite("active_weapon_prescaler",global.pistol_scale)
        break
        
        case spr_pistol:
            varWrite("arm_pose",global.pistol_pose)
            varWrite("active_weapon_prescaler",global.pistol_scale)
        break
        
        case spr_rifle:
            varWrite("arm_pose",global.rifle_pose)
            varWrite("active_weapon_prescaler",global.rifle_scale)
        break
        
        case spr_torque:
            varWrite("arm_pose",global.torque_pose)
            varWrite("active_weapon_prescaler",global.torque_scale)
        break
        
        case spr_shotgun:
            varWrite("arm_pose",global.shotgun_pose)
            varWrite("active_weapon_prescaler",global.shotgun_scale)
        break
        
        case spr_frag:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_flame:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.flame_scale)
        break
        
        case spr_snare:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.snare_scale)
        break
        
        case spr_smoke:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_flashbang:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_ink:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_sticky:
            varWrite("arm_pose",global.nade_pose)
            varWrite("active_weapon_prescaler",global.nade_scale)
        break
        
        case spr_longshot:
            varWrite("arm_pose",global.longshot_pose)
            varWrite("active_weapon_prescaler",global.longshot_scale)
        break
    
        case spr_smg:
            varWrite("arm_pose",global.smg_pose)
            varWrite("active_weapon_prescaler",global.smg_scale)
        break
        
        case spr_lmg:
            varWrite("arm_pose",global.lmg_pose)
            varWrite("active_weapon_prescaler",global.lmg_scale)
        break

        case spr_vulcan:
            varWrite("arm_pose",global.vulcan_pose)
            varWrite("active_weapon_prescaler",global.vulcan_scale)
        break    
        
        case spr_boom:
            varWrite("arm_pose",global.boom_pose)
            varWrite("active_weapon_prescaler",global.boom_scale)
        break
        
        case spr_rocket:
            varWrite("arm_pose",global.rocket_pose)
            varWrite("active_weapon_prescaler",global.rocket_scale)
        break  
        
        case spr_double:
            varWrite("arm_pose",global.double_pose)
            varWrite("active_weapon_prescaler",global.double_scale)
        break  
        
        case spr_stomper:
            varWrite("arm_pose",global.stomper_pose)
            varWrite("active_weapon_prescaler",global.stomper_scale)
        break  
        
        case spr_boltok:
            varWrite("arm_pose",global.boltok_pose)
            varWrite("active_weapon_prescaler",global.boltok_scale)
        break   
        
        case spr_tickler:
            varWrite("arm_pose",global.tickler_pose)
            varWrite("active_weapon_prescaler",global.tickler_scale)
        break 
        
        case spr_thumper:
            varWrite("arm_pose",global.thumper_pose)
            varWrite("active_weapon_prescaler",global.thumper_scale)
        break 
        
        case spr_carbine:
            varWrite("arm_pose",global.carbine_pose)
            varWrite("active_weapon_prescaler",global.carbine_scale)
        break 
    }
}

/* */
/*  */
