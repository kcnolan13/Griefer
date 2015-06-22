///is_team_leader(player_obj)

player_obj = argument0

if !instance_exists(player_obj)
return -1

if net_manager.team > -1
{
    if objVarRead(player_obj,"uniqueId") >= ceil(net_manager.num_players/2)
    {
        if objVarRead(player_obj,"uniqueId") = ceil(net_manager.num_players/2)
            return true
        else
            return false
    }
    else
    {
        if objVarRead(player_obj,"uniqueId") = 0
            return true
        else
            return false
    }
}
else return false