///glr_lightsimple_set_sprite(light, sprite, subimage)
var da_light = argument0
var spr = argument1
if instance_exists(da_light)
{
    da_light.sprite = spr
} else printf("ERROR: light sprite cannot be set -- doesn't exist!")
return true

//
//
//OLD SHIT
//
//

argument0[| 9] = argument1;
argument0[| 10] = argument2;