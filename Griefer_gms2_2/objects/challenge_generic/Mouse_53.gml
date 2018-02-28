/// @description redeem your gear
if not instance_place(x,y,cursor) exit

if not in_match() and net_manager.menu_mode = "challenges" and completed
{
    var goto_armory = false
    new = false
    for (var i=0; i<getLength(rewards); i++)
    {
        if not bpart_has_armor_lists(rewards[i]) and not bpart_has_cache(rewards[i])
        {
            audio(snd_pan4,GAIN_PAN)
            destList = global.cache
            
            /* screw this for now
            limbType = bpart_lookup(rewards[i],global.BPART_LIMB_TYPE)
            bpartList = get_bpart_list(limbType)
            listInd = get_bpart_list_index(limbType)
            if ds_list_size(bpartList) = 0 or not instance_exists(bpartList[| 0])
            {
                //instantiate right into your gear
                net_manager.armory_disabled[listInd] = false
                destList = bpartList
            }*/
            
            blah = instantiate_bpart(rewards[i],global.src_challenge, destList)
            blah.txt_new = net_manager.txt_new
            blah.col_new = net_manager.col_challenge
            blah.new = true
            goto_armory = true
        }
    }
    
    if goto_armory
    {
        net_manager.menu_mode = "armory"
    }
    
}

/* */
/*  */
