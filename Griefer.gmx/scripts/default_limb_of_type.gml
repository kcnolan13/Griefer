///default_limb_of_type(limb_type)
var limb_type = argument0

var i=0
var spr = 0

while (bpart_lookup(spr,global.BPART_LIMB_TYPE) != limb_type)
{
    spr++
    if spr > spr_prop return -1
}

return spr