///convert_spr_none_to_drawable(sprite_2draw, limb_name)
//intercept and replace spr_none with whatever the default is
var limb_drawable = argument0
var limb = argument1

if is_sprite_none(limb_drawable)
{
    switch (limb)
    {
        case "hat0":
            limb_drawable = global.default_hat
        break
        
        case "helmet0":
            limb_drawable = global.default_helmet
        break
        
        case "torso0":
            limb_drawable = global.default_torso
        break
        
        case "leg0":
            limb_drawable = global.default_leg
        break
        
        case "shin0":
            limb_drawable = global.default_shin
        break
        
        case "foot0":
            limb_drawable = global.default_foot
        break
        
        case "shoulder0":
            limb_drawable = global.default_shoulder
        break
        
        case "forearm0":
            limb_drawable = global.default_forearm
        break
    }
}

return limb_drawable