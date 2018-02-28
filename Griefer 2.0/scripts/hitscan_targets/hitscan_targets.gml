/// @description hitscan_targets(x1, y1, x2, y2, target, prec, notme, from_player)
/// @function hitscan_targets
/// @param x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  target
/// @param  prec
/// @param  notme
/// @param  from_player
var dx, dy, first_instance, temp, is_same_team

instance = noone

var from_player = argument7

if not instance_exists(from_player) or from_player.object_index != player
{
    printf("ERROR: cannot hitscan_targets because from_player="+string(from_player))
    return noone
}

if counter < 1 col = c_green else col = c_blue

first_instance = noone
is_same_team = true
is_block = false

dx = argument2 - argument0
dy = argument3 - argument1

var loops = 0
while ((abs(dx) >= 1 or abs(dy) >= 1) and loops < 10000)
{
    loops++
    
    dx /= 2
    dy /= 2
    
    from_player.hitscan_xi = argument0
    from_player.hitscan_yi = argument1
    from_player.hitscan_xf = argument2-dx
    from_player.hitscan_yf = argument3-dy
    from_player.hitscan_obj = argument4
    from_player.hitscan_prec = argument5
    from_player.hitscan_notme = argument6
    
    with from_player
    {
        other.instance = collision_line(hitscan_xi, hitscan_yi, hitscan_xf, hitscan_yf, hitscan_obj, hitscan_prec, hitscan_notme)
    }
   
    if (instance != noone)
    {
    
        if not instance.object_index > 0
            printf(":::WARNING: hitscan_targets says instance "+string(instance)+" has object_index "+string(instance.object_index))
    
        if instance.object_index != player or (instance.id != from_player.id and not are_teammates(instance, from_player))
        {
            is_same_team = false
            first_instance = instance
            argument2 -= dx
            argument3 -= dy
        }
        else
        {
            if instance.id = from_player.id
                printf(":::WARNING: hitscanning ran into from_player: "+playerName(from_player)+" = "+string(playerName(instance)))
            else if are_teammates(instance, from_player)
            {
                printf(":::WARNING: hitscaning passing through teammate")
                argument0 += trigx(point_distance(argument0,argument1,instance.x,instance.y)+5,point_direction(argument0,argument1,argument2,argument3))
                argument1 += trigy(point_distance(argument0,argument1,instance.x,instance.y)+5,point_direction(argument0,argument1,argument2,argument3))
            }
        }
    }
}

if is_same_team
{
    //printf("::: is_same_team was true")
    first_instance = noone
}
else
{
    //printf("::: is_same_team was false")
}

collision_x = argument2-dx
collision_y = argument3-(dy*2)

return first_instance
