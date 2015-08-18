///in_my_ink(object)
var obj = argument0
var obscurred = false

if counter < life+part_life/3 and  point_distance(x,y,obj.x,obj.y) < snare_radius///*counter > 30*1 and*/ abs(obj.x - x) < 64*2.25 and obj.y < y+64*1 and (obj.y > y-64*4 or (obj.y > y-64*7 and counter > 30*3))
{
    obscurred = true
}

return obscurred