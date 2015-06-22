///lose_gear(gear_sprite)
var gear_sprite = argument0

printf("GEAR LOSS TRIGGER: sprite_index = "+string(gear_sprite))

var limb_type = bpart_lookup(gear_sprite,global.BPART_LIMB_TYPE)
printf("    this is a "+limb_type)
//get a handle to the list for this bpart
var loss_list_handle = get_bpart_list(limb_type)

if not ds_exists(loss_list_handle,ds_type_list)
{
    printf("ERROR: bad loss_list handle")
    return false
}

//find the index of this sprite in the loss_list
bpart_temp = loss_list_handle[| 0]
net_manager.bpart_transacted = bpart_temp
printf("LOSING GEAR!!! "+bpart_temp.name+" : "+bpart_temp.limb_type)

if net_manager.steal_mode = GEAR_CLONE
{
    objVarWrite(net_manager,"lost_gear",true)
    objVarWrite(net_manager,"stole_gear",false)
    objVarWrite(net_manager,"transacted_player",varRead("lost_gear_source"))
    objVarWrite(net_manager,"lost_gear_sprite",varRead("gear_to_lose"))
    
    varWrite("gear_to_lose",false) 
    varWrite("lost_gear_source",false) 
    return true
} else
{
    //replace the gear with disabled slot
    printf("instantiating disabled slot")
    ID2 = instantiate_bpart(spr_helmet_none+get_bpart_list_index(limb_type),global.src_disabled,loss_list_handle)  //spr_helmet_none+i is known to be the sprite_index for the spr_none that applies to this limb type
    if instance_exists(ID2)
    {
        ID2.disabled = true
        net_manager.armory_disabled[get_bpart_list_index(limb_type)] = true
        loss_list_handle[| ds_list_size(loss_list_handle)-1] = bpart_temp
        loss_list_handle[| 0] = ID2
        
        //SCRAP THE GEAR
        ds_list_delete(loss_list_handle,ds_list_size(loss_list_handle)-1)
        
        with net_manager
            sync_my_doll()
            
        //with bpart_temp instance_destroy() 
        
        objVarWrite(net_manager,"lost_gear",true)
        objVarWrite(net_manager,"stole_gear",false)
        objVarWrite(net_manager,"transacted_player",varRead("lost_gear_source"))
        objVarWrite(net_manager,"lost_gear_sprite",varRead("gear_to_lose"))
        
        varWrite("gear_to_lose",false) 
        varWrite("lost_gear_source",false)   
    
        return true
    } else
    {
        printf("failed to instantiated disabled slot")
        printf("ERROR: couldn't delete the bpart you lost")
        return false
    }
}