///are_teammates(player_obj,player_obj2)
player_obj = argument0
player_obj2 = argument1

if not instance_exists(player_obj) or not instance_exists(player_obj2)
    return false

if net_manager.team > -1
{
    if objVarRead(player_obj,"pNum") >= ceil(net_manager.num_players/2)
        theTeam = 1
    else
        theTeam = 0
        
    if objVarRead(player_obj2,"pNum") >= ceil(net_manager.num_players/2)
        theTeam2 = 1
    else
        theTeam2 = 0
        
    if theTeam2 = theTeam
        return true
    else
        return false
}
else return false