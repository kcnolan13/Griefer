///glr_lightsimple_set_scaling(light id, xscale, yscale)
var da_light = argument0
var xsc = argument1
var ysc = argument2
if instance_exists(da_light)
{
    da_light.xscale = xsc
    da_light.yscale = ysc
} else printf("ERROR: light scale cannot be set -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

argument0[| 4] = argument1;
argument0[| 5] = argument2;