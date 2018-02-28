/// @description do physics and make particles

if bleed_time
{
    repeat(blood_parts)
    {
        dx = random_range(-1*bxoff,bxoff)
        dy = random_range(-1*byoff,byoff)
        bld = instance_create(x+dx,y+dy,blood_particle)
        bld.dir = random_range(0,360)
        bld.blend = blood_color
        var spd = bleed_strength
        {
            bld.spd = spd
            bld.hsp = trigx(spd,bld.dir)
            bld.vsp = trigy(spd,bld.dir)
        }
    }
    bleed_time--
    bleed_strength = lerp_real(bleed_strength,22,bleed_lerp_real)
}

counter += real_speed(1)

part_emitter_region(sys_smoke,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

if counter < life
{
    part_type_speed(ps,0,real_speed(3),real_speed(0.015),real_speed(0.1))
    
    if fps < 25 and truthval(global.gc[GC_PARTICLES,1])
        part_type_alpha3(ps,0.25,1,0)
    else
        part_type_alpha3(ps,0.25,3,0)
    
    if fps >= 25 and truthval(global.gc[GC_PARTICLES,1])
    {
        if random(1) < 0.10
            part_emitter_burst(sys_smoke,em,ps,1)
    }
    else if random(1) < 0.075
    {
        part_emitter_burst(sys_smoke,em,ps,1)
    }
}

if counter > life+part_life
{
    printf("destroying smoke system")
    instance_destroy()
    exit
}

if varRead("local")
{
    for (ind=0; ind<instance_number(player); ind++)
    {
        dat_playa = instance_find(player,ind)
        if counter < life+part_life/4 and in_my_ink(dat_playa) and objVarRead(dat_playa,"alive") and objVarRead(dat_playa,"hp") > 0 and dat_playa.alive_counter > 30*2
        {
            objVarWrite(dat_playa,"speed_multiplier",speed_multiplier)
            obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
            
            //hurt the player
            from_player = find_player(varRead("senderId"))
            printf("ink damaging player")
            damage_splosion()
        }
        else
        {
            //printf("player not in ink: "+objVarRead(dat_playa,"alive")+", "+objVarRead(dat_playa,"hp")+", "+dat_playa.alive_counter)
            if objVarRead(dat_playa,"speed_multiplier") = speed_multiplier
            {
                printf("freeing player from ink")
                objVarWrite(dat_playa,"speed_multiplier",1)
                obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
            }
        }
    }
}

