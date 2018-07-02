/// @description do physics and make particles
if not part_system_exists(particle_controller.sys_flame)
{
    instance_destroy()
    exit
}

counter += real_speed(1)

part_emitter_region(particle_controller.sys_flame,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

if counter < life
{
    if random(1) < 0.22
        part_emitter_burst(particle_controller.sys_flame,em,particle_controller.part_flame,1)
}

if counter > life+part_life+linger_time
{
    printf("destroying fire system")
    instance_destroy()
    exit
}

if varRead("local")
{
    for (ind=0; ind<instance_number(player); ind++)
    {
        dat_playa = instance_find(player,ind)
        
        if ((counter < life+part_life/3 and in_my_flame(dat_playa)) or objVarRead(dat_playa,"fire_counter")) and objVarRead(dat_playa,"alive") and objVarRead(dat_playa,"hp") > 0 and dat_playa.alive_counter > 30*2
        {
            //objVarWrite(dat_playa,"speed_multiplier",speed_multiplier)
            //obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
            
            //hurt the player
            from_player = find_player(varRead("senderId"))
            printf("flame damaging player")
            damage_splosion()
        }
        /*else
        {
            //printf("player not in ink: "+objVarRead(dat_playa,"alive")+", "+objVarRead(dat_playa,"hp")+", "+dat_playa.alive_counter)
            if objVarRead(dat_playa,"speed_multiplier") = speed_multiplier
            {
                printf("freeing player from flame")
                objVarWrite(dat_playa,"speed_multiplier",1)
                obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
            }
        }*/
    }
}

/* */
/*  */
