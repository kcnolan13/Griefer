///is_local_teammate(player_obj)
player_obj = argument0

if net_manager.team > -1
{
    if are_teammates(player_obj,net_manager.local_player)
        return true
    else
        return false
    /*if not is_bot(player_obj)
    {
        if objVarRead(player_obj,"uniqueId") >= ceil(net_manager.num_players/2)
            theTeam = 1
        else
            theTeam = 0
            
        if net_manager.team = theTeam
            return true
        else
            return false
    }
    else
    {
        //if SUPER_DEBUG
            printf("(object "+object_index+") is using bot version of is_local_teammate()")
            
        if not instance_exists(net_manager.local_player)
        {
            printf("ERROR: using bot version of is_local_teammate() and NO LOCAL PLAYER to be found")
            return false
        }
            
        var t1 = get_team(net_manager.local_player)
        var t2 = get_team(player_obj)
        if t1 != -1 and t2 != -1 and t1 = t2
        {
            printf("bot "+objVarRead(player_obj,"pName")+" is your teammate!")
            return true
        }
        else
            return false
    }*/
}
else return false