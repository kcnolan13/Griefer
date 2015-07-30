///sync_my_doll()

if not local_dollsync
armor_modified = true

with net_manager
{
    if not instance_exists(my_doll)
    {
        printf("ERROR: cannot sync my_doll: does not exist")
        return false
    }

    my_doll.alarm[2] = 1
    
    //grab the first sprite from each armory ds list
    var_strs[0] = "helmet"
    var_strs[1] = "torso"
    var_strs[2] = "leg"
    var_strs[3] = "shin"
    var_strs[4] = "hat"
    var_strs[5] = "shoulder"
    var_strs[6] = "forearm"
    var_strs[7] = "foot"
    var_strs[8] = "prop"
    
    obj_pname_update_real(my_doll,"rank",FL_NORMAL)
    obj_pname_update_real(my_doll,"global_rank",FL_NORMAL)
    
    for (var i=0; i<NUM_LIMBS; i++)
    {
        var handle = ds_list_find_value(armory_lists,i)
        
        if ds_exists(handle,ds_type_list)
        {
            var slot0 = ds_list_find_value(handle,0)
            if not instance_exists(slot0)
            {
                printf("    --not syncing this slot; doesn't exist")
                continue
            }
            varWrite(var_strs[i]+"0",slot0.icon)
            varWrite(var_strs[i]+"0_src",slot0.source)
            
            objVarWrite(my_doll,var_strs[i]+"0",slot0.icon)
            objVarWrite(my_doll,var_strs[i]+"0_src",slot0.source)
            
            obj_pname_update_real(my_doll,var_strs[i]+"0",FL_NORMAL)
            obj_pname_update_real(my_doll,var_strs[i]+"0",FL_NORMAL) //was slot0.icon for some reason
        } else 
        {
            printf("ERROR: cannot sync doll. BAD ARMORY_LIST handle")
            return false
        }
    }
}
return true