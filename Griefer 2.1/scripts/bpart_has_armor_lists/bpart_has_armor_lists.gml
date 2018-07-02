/// @description bpart_has_armor_lists(bpart_sprite)
/// @function bpart_has_armor_lists
/// @param bpart_sprite
var spr = argument0

for (var i=0; i<NUM_LIMBS; i++)
{
    var list = ds_list_find_value(net_manager.armory_lists,i)
    if ds_exists(list,ds_type_list)
    {
        var len = ds_list_size(list)
        for (j=0; j<len; j++)
        {
            var bpart = ds_list_find_value(list,j)
            if not is_undefined(bpart) and instance_exists(bpart)
            {
                if bpart.object_index = bpart_generic
                {
                    if bpart.icon = spr
                        return true
                }
            }
        }   
    }
}
return false