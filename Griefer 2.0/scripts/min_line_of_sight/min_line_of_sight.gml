/// @description min_line_of_sight(reference_object,target_object)
/// @function min_line_of_sight
/// @param reference_object
/// @param target_object
var reference_object = argument0
var target_object = argument1

var los_min = room_width

{
    try_x[0] = target_object.x
    try_y[0] = target_object.y
    try_x[1] = target_object.x
    try_y[1] = target_object.bbox_top+1
    try_x[2] = target_object.x
    try_y[2] = target_object.bbox_bottom-1
    los_ranges[0] = room_width
    los_ranges[1] = room_width
    los_ranges[2] = room_width
}
        
for (var j=0; j<3; j++)
{
    if not collision_line(reference_object.x,reference_object.y,try_x[j],try_y[j],solid_generic,true,false)
    {
        los_ranges[j] = point_distance(reference_object.x,reference_object.y,try_x[j],try_y[j])
    }
}

los_min = min(los_ranges[0],los_ranges[1],los_ranges[2])

if los_min < room_width
{
    if SUPER_DEBUG
        printf("        min line of sight from (object "+reference_object+") to (object "+target_object+" : "+los_min)
    return los_min
}
else
{
    if SUPER_DEBUG
        printf("        NO LINE OF SIGHT from (object "+reference_object+") to (object "+target_object+")")
    return -1
}