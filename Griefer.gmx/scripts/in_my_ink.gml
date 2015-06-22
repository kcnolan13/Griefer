///in_my_ink(object)
var obj = argument0
var obscurred = false

if /*counter > room_speed*1 and*/ abs(obj.x - x) < 64*3.5 and obj.y < y+64*1 and (obj.y > y-64*6.5 or (obj.y > y-64*11 and counter > room_speed*3))
{
    obscurred = true
}

return obscurred