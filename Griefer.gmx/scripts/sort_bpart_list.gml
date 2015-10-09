///sort_bpart_list(list)
var list = argument0

//sort the list
var len = ds_list_size(list)
new_list = ds_list_create()
list_grid = ds_grid_create(2,len)

//populate cache map
for (var i=0; i<len; i++)
{
    var item = list[| i]
    if instance_exists(item)
    {
        ds_grid_add(list_grid,0,i,item)
        ds_grid_add(list_grid,1,i,item.icon)
    }
    else 
    {
        printf("ERROR: item does not exist in manage_cache")
    }
}

ds_grid_sort(list_grid,1,true)

//BUILD NEW LIST
for (var i=0; i<len; i++)
{
    ds_list_add(new_list,ds_grid_get(list_grid,0,i))
}

//free up dynamically allocated memory
ds_grid_destroy(list_grid)
ds_list_destroy(list)

return new_list
