///bpart_mod_val(bpart_sprite)
var spr = argument0
var len = getLength(global.mod_limbvars)

for (var i=0; i<len; i++)
{
    if global.mod_limbs[i] = spr
        return global.mod_vals[i]
}

return GARBAGE