///hitscan_targets(x1, y1, x2, y2, target, prec, notme, from_player)
var dx, dy, instance, first_instance, temp

var from_player = argument7

if counter < 1
col = c_green
else
col = c_blue

/*if counter < 1
{
    blah = instance_create(argument0,argument1,hit_marker)
    objVarWrite(blah,"image_blend",col)
    blah.image_blend = col
    
    blah = instance_create(argument2,argument3,hit_marker)
    objVarWrite(blah,"image_blend",col)
    blah.image_blend = col
}*/

dx=0
dy=0

first_instance = noone

temp = collision_line(argument0, argument1, argument2, argument3, argument4, argument5, argument6)
if (temp != noone)
{
    if temp.object_index != player or (temp != from_player and not are_teammates(temp, from_player))
    {
        first_instance = temp
    }
}

if(first_instance != noone)
{
    dx = argument2 - argument0
    dy = argument3 - argument1
    while (abs(dx) >= 1 or abs(dy) >= 1)
        {
            dx /= 2
            dy /= 2
            instance = collision_line(argument0, argument1, argument2-dx, argument3-dy, argument4, argument5, argument6)
            if (instance != noone)
            {
                if instance.object_index != player or (instance != from_player and not are_teammates(instance, from_player))
                {
                    first_instance = instance
                    argument2 -= dx
                    argument3 -= dy
                }
            }
        }
}

collision_x = argument2-dx
collision_y = argument3-(dy*2)

return first_instance