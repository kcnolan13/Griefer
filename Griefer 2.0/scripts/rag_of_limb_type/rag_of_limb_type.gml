/// @description rag_of_limb_type(limb_type -- name or list index!)
/// @function rag_of_limb_type
/// @param limb_type -- name or list index!
var type = argument0
var ind = 0

if is_string(argument0)
{
    ind = get_bpart_list_index(type)
    if ind < 0 or ind >= getLength(global.bpart_limb_types)
    {
        printf("ERROR: find_rag_of_type indexing out of bpart_limb_types bounds")
        return NO_HANDLE
    }
}
else
{
    ind = type
}

return rag_head+ind