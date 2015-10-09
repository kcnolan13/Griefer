///manage_cache

//REMOVE ALL DUPLICATES
remove_duplicate_bparts(global.cache,global.cache)
remove_duplicate_bparts(global.hats,global.cache)
remove_duplicate_bparts(global.helmets,global.cache)
remove_duplicate_bparts(global.torsos,global.cache)
remove_duplicate_bparts(global.legs,global.cache)
remove_duplicate_bparts(global.shins,global.cache)
remove_duplicate_bparts(global.feet,global.cache)
remove_duplicate_bparts(global.shoulders,global.cache)
remove_duplicate_bparts(global.forearms,global.cache)
remove_duplicate_bparts(global.props,global.cache)

remove_duplicate_bparts(global.hats,global.hats)
remove_duplicate_bparts(global.helmets,global.helmets)
remove_duplicate_bparts(global.torsos,global.torsos)
remove_duplicate_bparts(global.legs,global.legs)
remove_duplicate_bparts(global.shins,global.shins)
remove_duplicate_bparts(global.feet,global.feet)
remove_duplicate_bparts(global.shoulders,global.shoulders)
remove_duplicate_bparts(global.forearms,global.forearms)
remove_duplicate_bparts(global.props,global.props)

//SORT THE CACHE
var len = ds_list_size(global.cache)
new_cache = ds_list_create()
cache_grid = ds_grid_create(2,len)

//populate cache map
for (var i=0; i<len; i++)
{
    var item = global.cache[| i]
    if instance_exists(item)
    {
        ds_grid_add(cache_grid,0,i,item)
        ds_grid_add(cache_grid,1,i,item.icon)
    }
    else 
    {
        printf("ERROR: item does not exist in manage_cache")
    }
}

ds_grid_sort(cache_grid,1,true)

//BUILD NEW LIST
for (var i=0; i<len; i++)
{
    ds_list_add(new_cache,ds_grid_get(cache_grid,0,i))
}

//map is no longer needed
ds_grid_destroy(cache_grid)

//OVERWRITE OLD LIST
ds_list_destroy(global.cache)
global.cache = new_cache
global.yo_bparts[| 9] = global.cache

printf(":::Cache Management Performed")
