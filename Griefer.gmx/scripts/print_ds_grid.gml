///print_ds_grid(grid)
var grid = argument0

printf("::: DS Grid Contents:")
for (var i=0; i<ds_grid_height(grid); i++)
{
    var str = ""
    for (var j=0; j<ds_grid_width(grid); j++)
    {
        str += string(ds_grid_get(grid,j,i))+" : "
    }
    printf("::: "+str)
}
