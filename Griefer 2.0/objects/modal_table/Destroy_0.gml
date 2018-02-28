/// @description free ds_grid and destroy pages

for (var i=0; i<getLength(pages); i++)
{
    if instance_exists(pages[i])
    {
        with pages[i] instance_destroy()
    }
}

if ds_exists(grid,ds_type_grid)
    ds_grid_destroy(grid)
    
if ds_exists(grid_header,ds_type_grid)
    ds_grid_destroy(grid_header)
    
if ds_exists(netvars,ds_type_map)
    ds_map_destroy(netvars)

