/// @description delete_invisible_gear()
/// @function delete_invisible_gear

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

    sync_my_doll()    
}
