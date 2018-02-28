/// @description disperse particles then die

if particles_spawned >= MAX_PARTICLES*size
{
    if DEBUG
        printf("blood_splosion finished spawning "+particles_spawned+" particles")
        
    instance_destroy()
}

//printf("size is "+size+", time is "+time)

for (var i=0; i < ceil(MAX_PARTICLES*size/time); i++)
{

    if instance_number(blood_particle) > MAX_PARTS and random(1) < 0.2 instance_destroy() //and not part_override exit
    
    //printf("    creating blood particle")
    particles_spawned++
    if truthval(global.gc[GC_PARTICLES,1])
    {
        ID = instance_create(x+random_range(-xy_variance,xy_variance),y+random_range(-xy_variance,xy_variance),blood_particle)
        ID.dir = dir+random_range(-dir_variance,dir_variance)
        ID.spd = spd+random_range(-spd_variance,spd_variance)
        ID.hsp = trigx(ID.spd,ID.dir)
        ID.vsp = trigy(ID.spd,ID.dir)
        ID.grav = grav
        ID.blend = blood_color
    }
}

