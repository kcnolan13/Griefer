/// @description instantiate_challenge(icon, name, description)
/// @function instantiate_challenge
/// @param icon
/// @param  name
/// @param  description
var icon = argument0
var name = argument1
var description = argument2
{
    cID = instance_create(x,y,challenge_generic)
    cID.color_complete = global.col_rarity[max(0,real(bpart_lookup(icon, global.BPART_RARITY)))]
    cID.icon_complete = icon
    cID.icon = icon
    cID.name = name
    cID.description = description
    cID.challenge_index = global.challenge_index
    global.challenge_index++
    
    cID.icon_scale = min(0.05,real(bpart_lookup(icon, global.BPART_SCALE)))
    ds_map_add(global.ds_challenges,name,cID)
    printf("added challenge: "+name+"   :   "+description)
    return cID
}