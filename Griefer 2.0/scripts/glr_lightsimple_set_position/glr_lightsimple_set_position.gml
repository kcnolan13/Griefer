/// @description glr_lightsimple_set_position(light id, x, y)
/// @function glr_lightsimple_set_position
/// @param light id
/// @param  x
/// @param  y
var da_light = argument0
var posx = argument1
var posy = argument2
if instance_exists(da_light)
{
    da_light.x = posx
    da_light.y = posy
} else printf("ERROR: light position cannot be set -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

argument0[| 1] = argument1;
argument0[| 2] = argument2;