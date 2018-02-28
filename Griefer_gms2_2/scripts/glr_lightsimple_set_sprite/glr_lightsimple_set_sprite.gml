/// @description glr_lightsimple_set_sprite(light, sprite, subimage)
/// @function glr_lightsimple_set_sprite
/// @param light
/// @param  sprite
/// @param  subimage
var da_light = argument0
var spr = argument1
if instance_exists(da_light)
{
    da_light.sprite = spr
} else printf("ERROR: light sprite cannot be set -- doesn't exist!")
return true
