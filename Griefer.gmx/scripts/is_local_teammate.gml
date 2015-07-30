///is_local_teammate(player_obj)
player_obj = argument0

if net_manager.team > -1
{
    if are_teammates(player_obj,net_manager.local_player)
        return true
    else
        return false
}
else return false