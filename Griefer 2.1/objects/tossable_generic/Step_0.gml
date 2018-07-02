/// @description all dah ish --> most of it computed by everyone
if varRead("play_stick_sound")
{
    audio(snd_sticky_stuck,1)
    varWrite("play_stick_sound",false)
}
depth = -80

//LOCAL BEHAVIOR
if varRead("local")
{
    if cook_time > 0 and (not start_cook_on_hit or have_hit_target)
    {
        cook_time = sub_real(cook_time,1)
        
        if SUPER_DEBUG
            printf("Cheffing up a fat one : T-Minus "+cook_time/30+" sec.")
            
        if not cook_time > 0 or splode_now
        {
            if DEBUG
                printf("wait for it ...")
            scr_unstick_tossable()
            
            if stuck and instance_exists(stuck_player)
            {
                varWrite("myX",stuck_player.x)
                varWrite("myY",stuck_player.y)
            }
            
            ID = instance_create_for_everyone(varRead("myX"),varRead("myY"),splosion)
            if sticky and stuck
            {
                ID.is_stick_kill = true
                printf("::: tossable_generic called for a stick_kill!")
            }
            objVarWrite(ID,"senderId",varRead("senderId"))
            objVarWrite(ID,"local",true)
            obj_update_string(ID,"senderId",FL_NORMAL)
            
            if object_index = bullet_flame
            {
                ID2 = instance_create_for_everyone(varRead("myX"),varRead("myY"),splosion_flame_instant)
                objVarWrite(ID2,"senderId",varRead("senderId"))
                objVarWrite(ID2,"local",true)
                obj_update_string(ID2,"senderId",FL_NORMAL)
            }
            
            if stuck
            {
                with (ID)
                {
                    event_perform(ev_alarm,0)
                    alarm[0] = 0
                }
            }
            instance_destroy_for_everyone(id)
        }
    }   
}

//UNIVERSAL BEHAVIOR

if varRead("speed") != -1 and not stuck
{
    hsp = trigx(varRead("speed"),varRead("direction"))
    vsp = trigy(varRead("speed"),varRead("direction"))
    varWrite("speed",-1)
}

if varRead("gravity") != -1 and not stuck
{
    grav = varRead("gravity")
    varWrite("gravity",-1)
}

if varRead("direction") != -1  and not stuck
{
    dir = varRead("direction")
    varWrite("direction",-1)
}

if varRead("rigidity") != -1 and not stuck
{
    rigidity = varRead("rigidity")
    varWrite("rigidity",-1)
}

if varRead("dir_perm") != -1 and not varRead("local")
{
    dir_perm = varRead("dir_perm")
    
    varWrite("dir_perm",-1)
}

if object_index = bullet_torque and not varRead("local")
{
    hsp = 0
    vsp = 0
    grav = 0
}

counter++

if not stuck //and (not sticky or varRead("local"))
{
    if not varRead("stationary")
    {
        vsp += real_speed(grav)
        recalc_tossable_vector()
        if point_distance(x,y,x+hsp,y+vsp) < varRead("max_speed")
        {
            hsp -= trigx(varRead("deceleration"),dir)
            vsp -= trigy(varRead("deceleration"),dir)
        }
    }
    else
    {
        hsp = 0
        vsp = 0
        spd = 0
        varWrite("can_rotate",false)
    }
}

if spd > 0 and not stuck and varRead("can_rotate") and object_index != bullet_torque
{
    fakedirection += rspeed*sign(rotation)*random_range(0.1,max(1,spd)/spd)
}

if not stuck and varRead("local") //and object_index = bullet_torque
    dir_perm = point_direction(x,y,x+hsp,y+vsp)

if spd > 0
{
    var inst = noone
    
    if sticky or object_index = bullet_smoke or object_index = bullet_boom or object_index = bullet_thumper 
        or object_index = bullet_rocket or object_index = bullet_flashbang or object_index = bullet_flame 
        or object_index = bullet_snare or object_index = bullet_ink
    {
        //COLLIDE WITH PLAYERS IN AIR
        inst = hitscan_targets(varRead("myX"), varRead("myY"), varRead("myX") + real_speed(hsp), varRead("myY") + real_speed(vsp), 
                                    shootable_generic, true,false,find_player(varRead("senderId")))
    }
    else 
    {
        //COLLIDE WITH BLOCKS ONLY
        inst = collision_line_first(varRead("myX"), varRead("myY"), varRead("myX") + real_speed(hsp), varRead("myY") + real_speed(vsp),
                                         solid_generic, true,true)
    }
    
    if inst
    {       
        have_hit_target = true
        
        if not audio_is_playing(varRead("sound_bounce")) and not stuck
            audio(varRead("sound_bounce"),1)
        
        if inst.object_index != player or (object_index = bullet_torque and not varRead("hitscan"))
            hit_bounce_target(inst,collision_x,collision_y)
        
        if object_index = bullet_smoke or object_index = bullet_boom or (object_index = bullet_thumper and inst.object_index = player) 
            or object_index = bullet_rocket or (object_index = bullet_flashbang and inst.object_index = player) 
            or object_index = bullet_ink or object_index = bullet_flame or object_index = bullet_snare
        {
            //EXPLODE IMMEDIATELY WHEN HIT TARGET
            splode_now = true
        }

        if inst.object_index = player and sticky and not stuck and (object_index != bullet_torque or varRead("hitscan"))
        {
            if varRead("local")
            {
                //STICK PLAYER
                
                play_stick_sound()
                if object_index = bullet_sticky
                    challenge_manager.sticky_kills ++

                //update stuck vars
                stuck_player = inst
                stuck = true
                varWrite("stuck_pname",string(playerName(inst)))
                varWrite("stuck_xoff",0)
                varWrite("stuck_yoff",y-inst.y)
                varWrite("stuck_xscaler",objVarRead(inst,"animation_xscale"))
                varWrite("stuck_ang",inst.torso_rot*-1)
                varWrite("can_rotate",false)
                
                //broadcast to other players that this nade is stuck and to whom it is bound
                obj_update_string(id,"stuck_pname",FL_NORMAL)
                obj_update_real(id,"stuck_xoff",FL_NORMAL)
                obj_update_real(id,"stuck_yoff",FL_NORMAL)
                obj_update_real(id,"stuck_xscaler",FL_NORMAL)
                obj_update_real(id,"stuck_ang",FL_NORMAL)
                obj_update_real(id,"can_rotate",FL_NORMAL)
                obj_sendval_real(id,"dir_perm",dir_perm,FL_NORMAL)
                varWrite("dir_perm",dir_perm) obj_update_real(id,"dir_perm",FL_NORMAL)
            }
        } 
        else if object_index = bullet_torque and not stuck and inst.object_index != player and not varRead("hitscan")
        {
            if bounces >= max_bounces
            {
                stuck = true
                varWrite("stuck_xoff",x)
                varWrite("stuck_yoff",y)
                
                //get stuck to nothing and tell other players about it
                if varRead("local")
                {
                    varWrite("stuck_pname","sticky_projectile_stuck_on_block")
                    varWrite("can_rotate",false)
                    obj_update_string(id,"stuck_pname",FL_NORMAL)
                    obj_update_real(id,"stuck_xoff",FL_NORMAL)
                    obj_update_real(id,"stuck_yoff",FL_NORMAL)
                    obj_update_real(id,"can_rotate",FL_NORMAL)
                    obj_sendval_real(id,"dir_perm",dir_perm,FL_NORMAL)
                    varWrite("dir_perm",dir_perm) obj_update_real(id,"dir_perm",FL_NORMAL)
                }
            }
            else
            {
                bounces++
            }
        }

    }
    else if not varRead("stationary")
    {
        varAdd("myX",real_speed(hsp))
        varAdd("myY",real_speed(vsp))
    }
}
else if not stuck and not varRead("stationary")
{
    varAdd("myX",real_speed(hsp))
    varAdd("myY",real_speed(vsp))
    scr_unstick_tossable()
    
    if !instance_position(x,bbox_bottom+1,solid_generic)
        varWrite("gravity",2)
    else
        varWrite("gravity",0)
}

x = varRead("myX")
y = varRead("myY")

if varRead("local") and nth_frame(5)
{
    obj_update_real(id,"myX",FL_NORMAL)
    obj_update_real(id,"myY",FL_NORMAL)
    
    if object_index = bullet_torque
    {
        obj_sendval_real(id,"dir_perm",dir_perm,FL_NORMAL)
    }
    
    if not stuck
    {
        recalc_tossable_vector()
        obj_sendval_real(id,"direction",dir,FL_NORMAL)
        obj_sendval_real(id,"speed",spd,FL_NORMAL)
    }
}

if sticky and is_string(varRead("stuck_pname"))
{
    sticky_stuck()
}

if varRead("local")
{
    if x = xprevious and y = yprevious
    {
        stationary_counter++
    } else stationary_counter = 0
    
    if stationary_counter > 4 and (not varRead("stationary") or nth_frame(5))
    {
        varWrite("stationary",true)
        obj_sendval_real(id,"stationary",true,FL_NORMAL)
    }
}

