/// @description do physics and make particles

counter += real_speed(1)

part_emitter_region(sys_smoke,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

if counter < life
{
    part_type_speed(ps,0,real_speed(0.75),real_speed(0.015),real_speed(0.1))
    if fps >= 25
    {
        if random(1) < 0.095
            part_emitter_burst(sys_smoke,em,ps,1)
    } else if random(1) < 0.065
    {   
        part_emitter_burst(sys_smoke,em,ps,1)
    }
}

if counter > life+part_life
{
    printf("destroying snare system")
    instance_destroy()
    exit
}

if varRead("local")
{
    for (ind=0; ind<instance_number(player); ind++)
    {
        dat_playa = instance_find(player,ind)
        if counter < life+part_life/4 and in_my_snare(dat_playa) and objVarRead(dat_playa,"alive") and objVarRead(dat_playa,"hp") > 0 and dat_playa.alive_counter > 30*2
        {
            if point_distance(x,y,dat_playa.x,dat_playa.y) <= point_distance(x,y,dat_playa.x+dat_playa.hsp,dat_playa.y)//+dat_playa.vsp)
            {
                if objVarRead(dat_playa,"speed_multiplier") = 1
                {
                    var do_snare = true
                    for (var i=0; i<getLength(pnames_snared); i++)
                    {
                        if objVarRead(dat_playa,"pName") = pnames_snared[i]
                            do_snare = false
                    }
                    
                    if do_snare and (dat_playa != net_manager.local_player and find_player(varRead("senderId")) = net_manager.local_player)
                    {
                        pnames_snared[snare_index] = objVarRead(dat_playa,"pName")
                        snare_index++
                        
                        challenge_manager.snare_kills ++
                        //update snare totals
                        increment_weapon_accolade("spr_snare")
                    }
                }
            
                objVarWrite(dat_playa,"speed_multiplier",speed_multiplier)
                obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
                
                dat_playa.hsp = trigx(20,point_direction(dat_playa.x,dat_playa.y,x,y))
                dat_playa.vsp = trigy(20,point_direction(dat_playa.x,dat_playa.y,x,y))
                
                //hurt the player
                from_player = find_player(varRead("senderId"))
                //printf("snaring player: hsp = "+dat_playa.hsp+", vsp = "+dat_playa.vsp)
                //damage_splosion()
            } else
            {
                //printf("freeing player: hsp = "+dat_playa.hsp+", vsp = "+dat_playa.vsp+", d1 = "+ point_distance(x,y,dat_playa.x,dat_playa.y)+", d2 = "+point_distance(x,y,dat_playa.x+dat_playa.hsp,dat_playa.y))
                objVarWrite(dat_playa,"speed_multiplier",1)
                obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
            }
        }
        else
        {
            //printf("player not in ink: "+objVarRead(dat_playa,"alive")+", "+objVarRead(dat_playa,"hp")+", "+dat_playa.alive_counter)
            if objVarRead(dat_playa,"speed_multiplier") = speed_multiplier
            {
                printf("freeing player from snare")
                objVarWrite(dat_playa,"speed_multiplier",1)
                obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
            }
        }
    }
}

