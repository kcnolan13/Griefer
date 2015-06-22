///print_ds_grid(grid)
var map = argument0

printf("::: DS Map Contents:")
for (var i=0; i<ds_map_size(map); i++)
{
    var next = ds_map_find_first(map)
    for (var i=0; i<ds_map_size(map)-1; i++)
    {
        printf("::: "+string(next)+" --> "+string(ds_map_find_value(map,next)))
        next = ds_map_find_next(map,next)
    }
}