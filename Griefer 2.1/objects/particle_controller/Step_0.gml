/// @description burst all particles
counter ++

part_type_speed(part_flame,0,real_speed(4),real_speed(0.015),real_speed(0.1))

for (var i=0; i<instance_number(player); i++)
{
    dat_playa = instance_find(player,i)

    if objVarRead(dat_playa,"fire_counter") and objVarRead(dat_playa,"alive") and objVarRead(dat_playa,"hp") > 0 and dat_playa.alive_counter > 30*2
    {
        var xoff = random_range(-24,24)
        var yoff = random_range(-48,48)
        var cnt = objVarRead(dat_playa,"fire_counter")
        if random(1) < 0.6
            part_particles_create(sys_flame,dat_playa.x+xoff, dat_playa.y+yoff,part_flame_small,min(4,(cnt+8)/9))
    }

}


particle_trail_emit(bullet_rocket,rocket_part1)
particle_trail_emit(bullet_boom,missile_part1)
particle_trail_emit(bullet_thumper,missile_part1)

//
//
//NO-FX CUTOFF
if not net_manager.tg_effects.active return false
//nothing else occurs if effects disabled
//
//


//particle_trail_emit(bullet_frag,part_frag_trail)
particle_trail_emit(bullet_sticky,part_sticky_trail)
particle_trail_emit(bullet_flame,part_flame_trail)
particle_trail_emit(bullet_ink,part_ink_trail)
particle_trail_emit(bullet_snare,part_snare_trail)
particle_trail_emit(bullet_smoke,part_smoke_trail)

for (var i=0; i<instance_number(die_generic); i++)
{
    dead_guy = instance_find(die_generic,i)
        
    if objVarRead(dead_guy,"fire_counter") > 0
    {
        objVarSub(dead_guy,"fire_counter",1)
        var xoff = random_range(-52,52)
        var yoff = random_range(-32,32)
        var cnt = objVarRead(dead_guy,"fire_counter")
        if random(1) < 0.6
            part_particles_create(sys_flame,dead_guy.x+xoff, dead_guy.y+64+yoff,part_flame_small,min(4,(cnt+8)/9))
    }

}

if instance_exists(snow) and fps >= 25 and truthval(global.gc[GC_PARTICLES,1])
{
    if random(1) < 0.2
        part_particles_create(sys_snow,0+random(room_width),-10,snow_part1,1)
}

if instance_exists(fog) or instance_exists(dust) or instance_exists(purple_haze) or instance_exists(green_haze)
if counter > 30*1.5 and fps >= 25 and truthval(global.gc[GC_PARTICLES,1])
 {
     if random(1) < 0.2
        part_particles_create(sys_fog,random(room_width),random(room_height),fog_part1,1)
 }

