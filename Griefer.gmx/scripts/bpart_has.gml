///bpart_has(bpart_sprite)
var spr = argument0

for (var i=0; i<NUM_LIMBS-1; i++)
{
    for (var j=0; j<NUM_BPARTS; j++)
    {
        if instance_exists(net_manager.my_doll)
        {
            if real(objVarRead(net_manager.my_doll,global.bpart_limb_types[i]+string(j))) = spr
            {
                return true
            }   
        }
        else
        {
            printf("ERROR: can't find your avatar")
            return false
        }
    }
}

return false