/// @description bpart_mod_index(bpart_sprite)
/// @function bpart_mod_index
/// @param bpart_sprite
var spr = argument0
var len = getLength(global.mod_limbvars)

for (var i=0; i<len; i++)
{
    if global.mod_limbs[i] = spr
        return i
}

return GARBAGE