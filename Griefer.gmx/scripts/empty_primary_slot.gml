///empty_primary_slot(player_obj)
var player_obj = argument0

if objVarRead(player_obj,"weapon0") < 0
{
    return 0
} else if objVarRead(player_obj,"weapon2") < 0
{
    return 2
} else return -1