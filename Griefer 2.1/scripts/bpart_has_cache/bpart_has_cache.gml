/// @description bpart_has_cache(bpart_sprite)
/// @function bpart_has_cache
/// @param bpart_sprite
var spr = argument0

for (var i=0; i<ds_list_size(global.cache); i++)
{
    var bpart = global.cache[| i]
    if not is_undefined(bpart) and instance_exists(bpart)
    {
        if bpart.object_index = bpart_generic
        {
            if bpart.icon = spr
                return true
        }
    }
}
return false