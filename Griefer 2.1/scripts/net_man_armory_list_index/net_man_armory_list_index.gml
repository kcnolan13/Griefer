/// @description net_man_armory_list_index(armory_list)
/// @function net_man_armory_list_index
/// @param armory_list
var my_list = argument0
for (var p=0; p<NUM_LIMBS; p++)
{   
    //printf("blah: "+my_list+", "+net_manager.armory_lists[| p])
    if net_manager.armory_lists[| p] = my_list
        return p
}
printf("ERROR: could not find this list's net_manager armory_lists index")
return -1