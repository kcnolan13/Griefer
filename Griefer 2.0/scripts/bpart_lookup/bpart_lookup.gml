/// @description bpart_lookup(sprite_index, bpart_index_constant)
/// @function bpart_lookup
/// @param sprite_index
/// @param  bpart_index_constant
var spr = argument0
var ind = argument1

if spr < array_height_2d(global.knowledge_base) and ind < array_length_2d(global.knowledge_base,spr)
{
    //printf("knowledge_base["+spr+","+ind+"] = "+global.knowledge_base[spr, ind])
    return global.knowledge_base[spr, ind]
}
else
{
    printf("OUTSIDE ARRAY BOUNDS: knowledge base lookup: sprite "+string(spr)+", index "+string(ind))
    return "-69"
}