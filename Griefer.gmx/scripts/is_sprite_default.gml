///is_sprite_default(sprite_index)
var spr = argument0

if spr = global.default_helmet
    or spr = global.default_torso
    or spr = global.default_leg
    or spr = global.default_shin
    or spr = global.default_hat
    or spr = global.default_shoulder
    or spr = global.default_forearm
    or spr = global.default_foot
    or spr = global.default_prop
        return true
else
        return false