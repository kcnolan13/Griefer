/// @description glr_lightsimple_set_color(light id, color);
/// @function glr_lightsimple_set_color
/// @param light id
/// @param  color
var da_light = argument0
var col = argument1
if instance_exists(da_light)
{
    da_light.color = col
} else printf("ERROR: light color cannot be set -- doesn't exist!")
return true
