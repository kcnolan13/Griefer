/// @description update_global_stat(ID, netvar, val)
/// @function update_global_stat
/// @param ID
/// @param  netvar
/// @param  val
var ID = argument0
var netvar = argument1
var val = argument2

if ID.object_index = net_manager
{
    printf("NEW GLOBAL STAT: "+string(netvar)+" = "+string(val))
    
    if netvar != "uniqueId"
        objVarWrite(ID,netvar,val)
    
    if instance_exists(my_doll)
    {
        objVarWrite(my_doll,netvar,val)
        printf("  --writing to your avatar")
    }
    else
    {
        printf("ERROR: CAN'T FIND YOUR AVATAR")
        return false
    }
    
    if in_match() or room = rm_lobby
    {
        printf("  --automatically forwarding to lobby members!")
        obj_update_real(my_doll,netvar,FL_NORMAL)
    }
    
    if instance_exists(local_player)
    {
        objVarWrite(local_player, netvar, val)
        printf(objVarRead(local_player,"pName")+" has a new GLOBAL STAT: "+string(netvar)+" = "+string(val))
        obj_update_real(local_player,netvar,FL_NORMAL)
    }
    else
    {
        printf("ERROR: couldn't find the local player")
    }
    
    printf("      DONE!")
    
} 
else if ID.object_index = avatar
{
    printf(objVarRead(ID,"pName")+"'s avatar has a new GLOBAL STAT: "+string(netvar)+" = "+string(val))
    objVarWrite(ID, netvar, val)
    
    if ID = my_doll
    {
    
        printf("     -- and he is the local player")
        
        if in_match() or room = rm_lobby
        {
            printf("forwarding to other.id players: "+string(objVarRead(my_doll,"pName"))+"."+string(netvar)+" = "+string(val))
            obj_pname_update_real(my_doll, netvar, FL_NORMAL) //av will have been updated directly already from back in receive_transmissions
        }
        
    }
}