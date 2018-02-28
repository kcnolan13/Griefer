/// @description framely weapon controls
if not global.map_editor
    framely_weapon_controls()

///standard behavior

if mi_jugador = -1 and not being_held()
    mi_jugador = NO_HANDLE

if varRead("active")
    was_active = true

if instance_exists(myCursor) and ((instance_exists(dat_jugador) and not is_bot(dat_jugador)) or not instance_exists(dat_jugador))
{
    if varRead("active")
    {
        myCursor.active = true
        myCursor.inaccuracy = varRead("inaccuracy")
    }
    else if was_active
    {
        was_active = false
        myCursor.active = false
    }
} else if instance_exists(dat_jugador) and not is_bot(dat_jugador) 
    printf("ERROR: nonexistant cursor for: "+varRead("name"))

if object_index = weapon_vulcan
{
    time_since_shot++
    if time_since_shot > 30 and varRead("cant_shoot_max") < varRead("cant_shoot_max_original")
    {
        varAdd("cant_shoot_max",1)
    }
}

//UNIVERSAL BEHAVIOR
if varRead("draw_trajectory")
    visible = true

//unbond from contemplation slot if picked up by someone else
if lobby_leader()
{
    if net_manager.local_player.weapon_contemplating = id
        net_manager.local_player.weapon_contemplating = NO_HANDLE
}

if being_held()
{
     varWrite("myX",objVarRead(dat_jugador,"myX"))
     varWrite("myY",objVarRead(dat_jugador,"myY"))
     varWrite("visible",false)
} 
else 
{
    //bail on reloading
    bail_on_reloading()
    
    //bail on charging
    bail_on_charging()

    varWrite("visible",true)
    image_xscale = PLAYER_SCALE*varRead("scale")
    image_yscale = PLAYER_SCALE*varRead("scale")
    
    //only apply physics if this weapon has been dropped by a player
    if varRead("been_picked_up")
        scr_basic_physics()
    
    if varRead("can_disappear") and varRead("disappear_counter") > 0
    {
        //DISAPPEAR EMPTY WEAPONS --> ONLY PLAYER 0 IS ALLOWED TO DO THIS
        varSub("disappear_counter",1)
        if varRead("disappear_counter") = 0 and lobby_leader()
        {
            printf("::: disappearing weapon: "+string(varRead("uniqueId"))+" : "+varRead("name"))
            instance_destroy_for_everyone(id)
            exit
        }
    }
    
    //DESTROY EMPTY WEAPONS --> ONLY PLAYER 0 IS ALLOWED TO DO THIS
    if varRead("ammo") < 1 and varRead("clip") < 1
    {
        if lobby_leader()
        {
            printf("::: destroying empty weapon: "+string(string(varRead("uniqueId")))+" : "+varRead("name"))
            instance_destroy_for_everyone(id)
            exit
        }
        else
        {
            printf("::: "+varRead("name")+" is empty, but not lobby_leader() so can't destroy it")   
        }
    }
}

//sync up real vars with net vars
//visible = varRead("visible")
x = varRead("myX")
y = varRead("myY")

//inaccuracy and handling
if varRead("inaccuracy") > 0
{
    var temp = div_real(varRead("inaccuracy"),varRead("handling"))
    if temp < 0.25
        varWrite("inaccuracy",0)
    else
        varWrite("inaccuracy",temp)
}

//LOCAL BEHAVIOR
    if varRead("active")
    {
    
        if object_index = weapon_torque
        {
            if varRead("charge") = 1
            {
                reached_hitscan = true
                varWrite("bullet_speed",1000)
                max_charge_counter++
                
                if max_charge_counter > varRead("max_charge_time")
                {
                    weapon_discharge()
                }
                
            } else 
            {
                reached_hitscan = false
                varWrite("bullet_speed",62)
                max_charge_counter = 0
            }
        }
    
        if varRead("charge") > 0 and not varRead("quicktoss_backcycles") and not is_bot(dat_jugador)
        {
            //draw projectile trajectory
            varWrite("draw_trajectory",true)
        }
        
        if not varRead("charge") > 0 or is_bot(dat_jugador)
        {
            varWrite("draw_trajectory",false)
            
            if match_ending() and torque_charging() 
            {
                weapon_release_left()
            }
        }
    
        if varRead("quicktoss_timer")
        {
            varSub("quicktoss_timer",real_speed(1))
            if varRead("quicktoss_timer") < 1
                varWrite("quicktoss_timer",0)
        }
    
        if varRead("is_nade")
        {
            objVarWrite(dat_jugador,"nades",varRead("clip"))
            obj_update_real(dat_jugador,"nades",FL_NORMAL)
        }
    
        if varRead("discharge_delay") > 0
        {
            //discharging in a few frames....
            varSub("discharge_delay",1)
            if varRead("discharge_delay") < 1
            {
                weapon_discharge()
            }
        }
    
        if varRead("cant_shoot")
            varSub("cant_shoot",real_speed(1))
        
        if varRead("cant_shoot") < 0
            varWrite("cant_shoot",0)
            
        //trigger a reload if empty (and enough time has passed)
        if varRead("clip") < varRead("clip_decrement") and varRead("ammo") > 0 and varRead("reload_counter") < 0
        {
            if varRead("reload_empty_counter") < 0
            {
                varWrite("reload_empty_counter",varRead("reload_empty_delay"))
            } else {
                varWrite("reload_empty_counter",sub_real(varRead("reload_empty_counter"),1))
                if not varRead("reload_empty_counter")
                {
                    //trigger the reload
                    trigger_reload()
                }
            }
        } else {
            varWrite("reload_empty_counter",-1)
        }
            
        if varRead("reload_counter") > 0
        {
            //printf("::: sub_real(varRead('reload_counter'),1) = "+string(sub_real(varRead("reload_counter"),1)))
            varWrite("reload_counter",sub_real(varRead("reload_counter"),1))
            if varRead("reload_incremental")
            {
                if (varRead("reload_time") - varRead("reload_counter") > (varRead("reload_time")/varRead("clip_cap"))*(1+varRead("clip")))
                {
                    //take a bullet from ammo and add to clip
                    if varRead("ammo") > 0 and varRead("clip") < varRead("clip_cap")
                    {
                        varAdd("clip",1)
                        varSub("ammo",1)
                        
                        audio(snd_reload_shell,1)
                        
                        //stop reloading at this point if no more ammo
                        if varRead("ammo") = 0
                        {
                            varWrite("reload_counter",-1)
                        }
                    }
                }
            }
            
            //FULL RELOAD WHEN READY
            if varRead("reload_counter") = 0
            {
                reload_full()
            }
        }
            
        //SEND NETWORK VARS
        if varRead("ammo_previous") != varRead("ammo") or varRead("clip_previous") != varRead("clip")
        {
            pkgCreate()
                obj_update_real(id,"clip",0)
                obj_update_real(id,"ammo",0)
                
                varWrite("ammo_previous",varRead("ammo"))
                varWrite("clip_previous",varRead("clip"))
                obj_update_real(id,"clip_previous",0)
                obj_update_real(id,"ammo_previous",0)
            pkgSend()
        }
        
    } else {
        //bail on reloading()
        bail_on_reloading()
        //bail on charging
        bail_on_charging()
    }

