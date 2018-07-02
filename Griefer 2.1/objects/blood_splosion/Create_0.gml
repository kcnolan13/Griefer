/// @description initialize


if not truthval(global.gc[GC_VIOLENT_CONTENT,1])
{
    instance_destroy()
    exit
}

//custom
size = 0.5          // 0-1
dir = 0
dir_variance = 20   //direction 
time = 5            //frames over which to disperse particle number
spd = 10            //particle spawn speed
spd_variance = 10   //particle spawn speed variance
xy_variance = 10    //paticle spawn xy variance
grav = 2
blood_color = c_green


//engine
particles_spawned = 0
MAX_PARTICLES = 40
part_override = false

if DEBUG
    printf("blood_splosion instantiated")

