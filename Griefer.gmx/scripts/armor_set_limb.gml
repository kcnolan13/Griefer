///armor_set_limb(armor_set_index, limb_type)
var ind = argument0
var limb_type = argument1

for (var i=global.armor_sets[ind,0]; i<=global.armor_sets[ind,1]; i++)
{
    if bpart_lookup(i,global.BPART_LIMB_TYPE) = limb_type
        return i
}

return random_bpart_limbtype(limb_type)