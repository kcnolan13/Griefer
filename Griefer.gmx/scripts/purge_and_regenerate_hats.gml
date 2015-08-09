///purge_and_recreate_hats()
printf("PURGE AND REGENERATE HATS")

for (var i=0; i<ds_list_size(global.hats); i++)
{
    printf("    --purging a hat")
    ds_list_delete(global.hats,i)
}

for (var M=0; M<10; M++)
{
    for (var N=4; N<5; N++)
    {
        var spr = varRead(global.bpart_limb_types[N]+M)
        if spr = global.spr_empty
        {
            if SUPER_DEBUG
                printf("NOT instantiating: "+global.bpart_limb_types[N]+string(M)+" = "+string(spr))
            //num_skipped ++
            continue
        }
        var src = varRead(global.bpart_limb_types[N]+M+"_src")
        if src = global.src_empty
        {
            if SUPER_DEBUG
                printf("NOT instantiating: "+global.bpart_limb_types[N]+string(M)+"_src"+" = "+string(src))
           // num_skipped ++
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
