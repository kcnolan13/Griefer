/// @description get_bpart_list(bpart_limb_type)
/// @function get_bpart_list
/// @param bpart_limb_type
var bpart_limb_type = argument0

for (var i=0; i<array_length_1d(global.bpart_limb_types); i++)
{
    if global.bpart_limb_types[i] = bpart_limb_type
    {
        return global.yo_bparts[| i]
    }
}

printf("ERROR: couldn't find list for bpart_type '"+bpart_limb_type+"'")