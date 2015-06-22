///glr_lightsimple_set_active(light id, active)
var da_light = argument0
if instance_exists(da_light)
{
    da_light.active = true
} else printf("ERROR: light cannot be set active -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

argument0[| 0] = argument1;