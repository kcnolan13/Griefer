/// @description random_bpart_limbtype(limb_type)
/// @function random_bpart_limbtype
/// @param limb_type
var limb_type = argument0

var counta = 0
var ind1 = spr_armor_placeholder1+1
var ind2 = spr_armor_placeholder2-0.1

if limb_type = global.bpart_limb_types[8]
{
    ind1 = spr_weapon_placeholder1+1
    ind2 = spr_weapon_placeholder2-0.1
}

if limb_type != global.bpart_limb_types[8]
    var rando_spr = roll_dice()
else
    var rando_spr = spr_none

while (bpart_lookup(rando_spr,global.BPART_LIMB_TYPE) != limb_type and counta < 500)
{
    if ind1 < spr_weapon_placeholder1+1
        rando_spr = roll_dice()
    else
    {
        rando_spr = floor(random_range(ind1, ind2))
        /*if random(1) < 1.1-varRead("rank")/array_length_1d(global.rank_names)
            rando_spr = spr_none*/
        
        break
    }
    
    if counta > 1900
    {
        if WARNINGS
            printf("WARNING: large loop: rando_bpart_limbtype()")
    }   
    counta++
}

if bpart_lookup(rando_spr,global.BPART_LIMB_TYPE) != limb_type
    rando_spr = get_bpart_list_index(limb_type)

return rando_spr