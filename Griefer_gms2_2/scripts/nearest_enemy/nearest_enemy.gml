/// @description nearest_enemy(player_obj)
/// @function nearest_enemy
/// @param player_obj
var pal = argument0

var guy = noone
var dist = room_width*room_width

//if nth_frame(15)
//printf("ERROR (not): finding nearest enemy to: "+string(varRead("pName")))

for (var i=0; i<instance_number(player); i++)
{
    var pot_guy = instance_find(player,i)
    
    //if nth_frame(15)
        //printf("ERROR (not): trying "+string(objVarRead(pot_guy,"pName")))
    
    if are_teammates(pal,pot_guy) and not string_count("tdm",objVarRead(net_manager,"game_mode"))
    {
        printf("ERROR: "+string(varRead("pName"))+" and "+string(objVarRead(guy,"pName"))+" are teammates")
    }
    
    if are_teammates(pal,pot_guy) or pal = pot_guy continue
    
    var pot_dist = point_distance(pal.x, pal.y, pot_guy.x, pot_guy.y)
    
    if pot_dist < dist
    {
        dist = pot_dist
        guy = pot_guy
    }
}

if instance_exists(guy)
{
    //if nth_frame(15)
        //printf("ERROR (not): nearest enemy to  "+string(varRead("pName"))+"  is:  "+string(objVarRead(guy,"pName")))
    return guy
}
else return noone