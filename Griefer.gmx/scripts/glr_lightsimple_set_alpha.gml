///glr_lightsimple_set_alpha(light id, alpha);
var da_light = argument0
var alpha = argument1
if instance_exists(da_light)
{
    da_light.alpha = alpha
} else printf("ERROR: light alpha cannot be set -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

argument0[| 7] = argument1;