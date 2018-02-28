/// @description particle_trail_emit(bullet_obj, particle)
/// @function particle_trail_emit
/// @param bullet_obj
/// @param  particle
var obj = argument0
var part = argument1

for (var i=0; i<instance_number(obj); i++)
{
    ID = instance_find(obj,i)
    
    if point_distance(ID.xprevious,ID.yprevious,ID.x,ID.y) > 0
    {
        for (n=0;n<point_distance(ID.xprevious,ID.yprevious,ID.x,ID.y);n+=2)
        {
            printf("bursting particles")
            ID.angle = point_direction(ID.xprevious,ID.yprevious,ID.x,ID.y)
            part_particles_create(particle_controller.sys_missile,ID.x+trigx(n,ID.angle),ID.y+trigy(n,ID.angle),part,1)
        }
    } else
    {
        part_particles_create(particle_controller.sys_missile,ID.x,ID.y,part,1)
    }
}