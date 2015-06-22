///glr_light_get_color(light id)
var da_light = argument0
if instance_exists(da_light)
{
    return da_light.color
} else printf("ERROR: light color cannot be checked -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

return argument0[| 6];