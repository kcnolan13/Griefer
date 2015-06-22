///print_ds_grid(grid)
var grid = argument0

printf("::: DS Grid Contents:")
for (var i=0; i<ds_grid_height(grid); i++)
{
    printf("::: "+string(ds_grid_get(grid,0,i))+" : "+string(ds_grid_get(grid,1,i))+" : "+string((ds_grid_get(grid,1,i)).object_index))
}