///unstick_in_direction(x_reference, y_reference, direction, sprite, strength, resolution)

var width = sprite_get_width(argument3)
var move_dir = argument2

if SUPER_DEBUG
    printf("unsticking in direction: "+argument2)

for (var i=0; i<argument4; i += argument5)
{
    var xadd = trigx(i,move_dir)
    var yadd = trigy(i,move_dir)

    if !collision_rectangle(argument0-width/2+xadd,argument1-width/2+yadd,argument0+width/2+xadd,argument1+width/2+yadd,solid_generic,true,true)
    {
        if SUPER_DEBUG
            printf("dx = "+xadd+", dy = "+yadd)
            
        argument0 += xadd
        argument1 += yadd
        return true
    }
}
return false