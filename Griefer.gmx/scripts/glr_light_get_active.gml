///glr_light_get_active(light id)
var da_light = argument0
if instance_exists(da_light)
{
    return da_light.active
} else printf("ERROR: light active cannot be checked -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

return argument0[| 0];