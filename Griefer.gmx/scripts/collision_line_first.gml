///collision_line_first(x1, y1, x2, y2, target, prec, notme)
var dx, dy, instance, first_instance

dx=0
dy=0

first_instance = collision_line(argument0, argument1, argument2, argument3, argument4, argument5, argument6)

if(first_instance != noone)
{
    dx = argument2 - argument0
    dy = argument3 - argument1
    var whiles = 0
    while (abs(dx) >= 1 or abs(dy) >= 1) and whiles < 1000
        {
            whiles++
            dx /= 2
            dy /= 2
            instance = collision_line(argument0, argument1, argument2-dx, argument3-dy, argument4, argument5, argument6)
            if(instance != noone)
            {
                first_instance=instance
                argument2 -= dx
                argument3 -= dy
            }
        }
}

collision_x = argument2-dx
collision_y = argument3-(dy*2)

return first_instance
