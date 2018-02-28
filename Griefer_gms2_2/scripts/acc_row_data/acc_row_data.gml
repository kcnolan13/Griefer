/// @description acc_row_data(row_num,col_num)
/// @function acc_row_data
/// @param row_num
/// @param col_num
var row_num = argument0
var col_num = argument1

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: acc_data cannot find accolade_manager's grid")
    return false
}

if row_num >= ds_grid_height(grid)
{
    printf("acc_row_data indexing out of grid: row = "+string(row_num))
    return false
}

return ds_grid_get(grid,col_num,row_num)