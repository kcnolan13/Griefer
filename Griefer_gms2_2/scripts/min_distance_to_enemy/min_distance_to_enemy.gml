/// @description min_distance_to_enemy(reference_object)
/// @function min_distance_to_enemy
/// @param reference_object
var reference_object = argument0

var dist_min = room_width*room_height
var distances = ds_list_create()
        
for (var j=0; j<instance_number(player); j++)
{
    var handle = instance_find(player,j)
    
    if are_teammates(id,handle) or handle = id
        continue
    
    ds_list_add(distances,point_distance(reference_object.x,reference_object.y,handle.x,handle.y))
}

ds_list_sort(distances,true)
dist_min = ds_list_find_value(distances,0)

//clean up dynamically allocated memory
ds_list_destroy(distances)

if dist_min < room_width*room_height
{
    if SUPER_DEBUG
        printf("        min distance from (object "+reference_object+") to an enemy : "+dist_min)
    return dist_min
}
else
{
    if DEBUG
        printf("NO MIN DISTANCE from (object "+reference_object+") to an enemy")
    return -1
}