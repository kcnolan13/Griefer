newuser_bparts[0] = spr_head
newuser_bparts[1] = spr_torso
newuser_bparts[2] = spr_leg
newuser_bparts[3] = spr_shin
newuser_bparts[4] = spr_none
newuser_bparts[5] = spr_shoulder
newuser_bparts[6] = spr_forearm
newuser_bparts[7] = spr_foot
newuser_bparts[8] = spr_none

for (var i=0; i<getLength(newuser_bparts); i++)
{
    var spr = newuser_bparts[i]
    var list = net_manager.armory_lists[| i]
    
    if spr != spr_none and ds_exists(list,ds_type_list) and ds_list_size(list) = 1
    {
        printf("::: instantiating newuser_bpart "+string(sprite_get_name(spr)))
        armory_disabled[i] = false
        
        bpart = instantiate_bpart(spr, "Default Gear", list)
        list[| 0] = bpart
        
        if ds_list_size(list) > 1
            ds_list_delete(list,1)
    }
    else
    {
        printf("ERROR: scr_instantiate_newuser_bparts ds_list_size(list) = "+string(ds_list_size(list)))
    }
}

sync_my_doll()
