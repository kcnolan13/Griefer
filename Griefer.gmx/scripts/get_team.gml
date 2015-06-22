///get_team(player_obj)
player_obj = argument0

if !instance_exists(player_obj)
return -1

if net_manager.team > -1
{
    if objVarRead(player_obj,"uniqueId") >= ceil(net_manager.num_players/2)
        return 1
    else
        return 0
}
else return -1