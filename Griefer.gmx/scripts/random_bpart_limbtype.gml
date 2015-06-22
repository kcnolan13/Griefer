///random_bpart_limbtype(limb_type)
var limb_type = argument0

var counta = 0
var ind1 = spr_armor_placeholder1+1
var ind2 = spr_armor_placeholder2-0.1

if limb_type = global.bpart_limb_types[8]
{
    ind1 = spr_weapon_placeholder1+1
    ind2 = spr_weapon_placeholder2-0.1
}

var rando_spr = floor(random_range(ind1,ind2))

while (string(bpart_lookup(rando_spr,global.BPART_LIMB_TYPE)) != string(limb_type) and counta < 2000)
{
    rando_spr = floor(random_range(ind1,ind2))
    
    if counta > 1900
    {
        if WARNINGS
            printf("WARNING: large loop: rando_bpart_limbtype()")
    }   
    counta++
}

return rando_spr