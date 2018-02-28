/// @description instantiate_all_bparts()
/// @function instantiate_all_bparts
//TO BE CALLED FROM NET MANAGER

if DEBUG
{
    printf("")
    printf("")
}
    printf("INSTANTIATING BODYPARTS...")
if SUPER_DEBUG
{
    printf("")
    printf("")
}

var num_skipped = 0

for (var M=0; M<NUM_BPARTS; M++)
{
    for (var N=0; N<NUM_LIMBS; N++)
    {
        var spr = varRead(global.bpart_limb_types[N]+string(M))
        if string(spr) = global.spr_empty
        {
            if SUPER_DEBUG
                printf("NOT instantiating: "+global.bpart_limb_types[N]+M+" = "+spr)
            num_skipped ++
            continue
        }
        var src = varRead(global.bpart_limb_types[N]+string(M)+"_src")
        if string(src) = global.src_empty
        {
            if SUPER_DEBUG
                printf("NOT instantiating: "+global.bpart_limb_types[N]+string(M)+"_src"+" = "+src)
            num_skipped ++
            continue
        }
        
        //this is a valid object. INSTANTIATE IT!
        var toList = get_bpart_list(bpart_lookup(spr,global.BPART_LIMB_TYPE))
        if ds_exists(toList,ds_type_list)
            instantiate_bpart(spr, src, toList)
        else
        {
            printf("ERROR: failed to instantiate object")
        }
    }
}

printf("DONE! "+string(instance_number(bpart_generic))+" bodyparts instantiated, "+string(num_skipped)+" skipped (empty)")
return true