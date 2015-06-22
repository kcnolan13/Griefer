///loop through all of your categories
printf("APPLYING RANDOM GEAR!")
for (var i=0; i<NUM_LIMBS; i++)
{
    var list = armory_lists[| i]
    if not ds_exists(list, ds_type_list)
    {
        printf("ERROR: bad handle to armory list")
        return false
    }
    
    //fill up each list
    var capacity = NUM_BPARTS
    if i=NUM_LIMBS-1
        capacity = NUM_PROPS
    var loops = 0
    
    if keyboard_check(vk_shift)
        var clear_start = 0
    else
        var clear_start = 1
        
        for (var j=clear_start; j<ds_list_size(list); j++)
        {
            with list[| j] instance_destroy()
            ds_list_delete(list,j)
        }  
    
    while ds_list_size(list) < capacity and loops < 100 //failsafe
    {
        loops++
        //pick a random sprite and try to add it
        var rando_spr
        if i<NUM_LIMBS-1
        {
            rando_spr = floor(random_range(spr_armor_placeholder1+1, spr_armor_placeholder2-0.01))
        } else
        {
            rando_spr = floor(random_range(spr_weapon_placeholder1+1, spr_weapon_placeholder2-0.01))
        }
        
       // printf("rando_spr = "+rando_spr)
        
        //break out of the loop if you have found a decent thing to add to the list
        if string(bpart_lookup(rando_spr,global.BPART_LIMB_TYPE)) = global.bpart_limb_types[i]
        {
            printf("good rando_spr!")
            instantiate_bpart(rando_spr,global.src_lotto,list)
        }
    }
    
    sync_my_doll()
    
}