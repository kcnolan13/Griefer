///bpart_has_cache(bpart_sprite)
var spr = argument0

for (var i=0; i<ds_list_size(global.cache); i++)
{
    var bpart = global.cache[| i]
    if instance_exists(bpart)
    {
        if bpart.object_index = bpart_generic
        {
            if bpart.icon = spr
                return true
        }
    }
}
return false