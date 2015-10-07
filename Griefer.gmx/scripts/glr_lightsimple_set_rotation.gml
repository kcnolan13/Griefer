///glr_lightsimple_set_rotation(light id, rotation)
var da_light = argument0
var rot = argument1
if instance_exists(da_light)
{
    da_light.rot = rot
} else printf("ERROR: light rot cannot be set -- doesn't exist!")
return true
