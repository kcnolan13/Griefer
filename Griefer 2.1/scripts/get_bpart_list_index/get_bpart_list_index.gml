/// @description get_bpart_list_index(bpart_limb_type)
/// @function get_bpart_list_index
/// @param bpart_limb_type
var bpart_limb_type = argument0

for (var i=0; i<array_length_1d(global.bpart_limb_types); i++)
{
    if global.bpart_limb_types[i] = bpart_limb_type
    {
        return i
    }
}

printf("ERROR: couldn't find list for bpart_type '"+bpart_limb_type+"'")