///is_team_leader(player_obj)

player_obj = argument0

if !instance_exists(player_obj)
return -1

if net_manager.team > -1
{
    if objVarRead(player_obj,"pNum") >= ceil(net_manager.num_players/2)
    {
        if objVarRead(player_obj,"pNum") = global.lowest_pnum_team2 //ceil(net_manager.num_players/2)
        {
            //printf("::: "+playerName(player_obj)+" is team leader of team 2 with pNum "+string(objVarRead(player_obj,"pNum")))
            return true
        }
        else
            return false
    }
    else
    {
        if objVarRead(player_obj,"pNum") = global.lowest_pnum
            return true
        else
            return false
    }
}
else return false
