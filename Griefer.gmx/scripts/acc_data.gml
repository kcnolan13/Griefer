///acc_data(name,col_num)
var name = argument0
var col_num = argument1

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: acc_data cannot find accolade_manager's grid")
    return false
}

if ds_grid_value_exists(grid,0,0,ds_grid_width(grid),ds_grid_height(grid)-1,name)
{
    var row_num = ds_grid_value_y(grid,0,0,0,ds_grid_height(grid)-1,name)
    return ds_grid_get(grid,col_num,row_num)
}
else
{
    printf("ERROR: acc_data cannot find the row number for name: "+string(name))
    //print_ds_grid(grid)
    return false
}
