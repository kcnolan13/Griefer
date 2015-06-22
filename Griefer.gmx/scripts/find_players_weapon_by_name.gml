///find_players_weapon_by_name(player, wep_name)
var player_obj = argument0
var wep_name = argument1

for (i=0; i<4; i++)
{
    var temp = objVarRead(player_obj,"weapon"+string(i))        
    if instance_exists(temp)
    {
        if wep_name = objVarRead(temp,"name")
            return temp
    }
}

return false