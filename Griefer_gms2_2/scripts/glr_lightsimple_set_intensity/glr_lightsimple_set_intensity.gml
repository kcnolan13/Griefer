/// @description glr_lightsimple_set_intensity(light id, intensity);
/// @function glr_lightsimple_set_intensity
/// @param light id
/// @param  intensity
var da_light = argument0
var intens = argument1
if instance_exists(da_light)
{
    da_light.intensity = intens
} else printf("ERROR: light intensity cannot be set -- doesn't exist!")
return true
