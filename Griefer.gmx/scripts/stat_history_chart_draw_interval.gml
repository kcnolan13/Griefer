///stat_history_chart_draw_interval(num_points,point_index,counter)
var pointnum = argument0
var ind = argument1

argument2 = argument2+1

if pointnum < 10
{

}
else if pointnum < 25
{
    if argument2 > 3
        argument2 = 1
}
else if pointnum < 105
{
    if argument2 > 7
        argument2 = 7
}

if pointnum < 10 or argument2 = 2
    return true
else
    return false
