///min_line_of_sight_to_enemy(reference_object, player)
var ref = argument0

//line of sight distances to all enemies
var lines_of_sight = ds_list_create()

for (var i=0; i<instance_number(player); i++)
{
    var ID = instance_find(player,i)
    
    //toss players that are not enemies
    if are_teammates(id,ID) continue
    
    //toss players that are you -- haha
    if ID = id continue
    
    var dist = min_line_of_sight(ref,ID)
    if dist > -1
    {
        //add to list of enemies this guy has line of sight to
        ds_list_add(lines_of_sight,dist)
    }
}

if ds_list_empty(lines_of_sight)
{
    //free dynamically allocated memory
    ds_list_destroy(lines_of_sight)

    //there is no line of sight to an enemy
    if SUPER_DEBUG
        printf("        ... no line of sight from ("+ref.x+", "+ref.y+") to any enemy ...")
    return -1
}
else
{
    ds_list_sort(lines_of_sight,true)
    var dat_return_do = ds_list_find_value(lines_of_sight,0)
    
    //free dynamically allocated memory
    ds_list_destroy(lines_of_sight)
    
    return dat_return_do
}