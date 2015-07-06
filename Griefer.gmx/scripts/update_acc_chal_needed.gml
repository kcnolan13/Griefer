///update_acc_chal_needed(name,val)
var name = argument0
var val = argument1

var col_num = COL_CHAL_NEEDED

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: update_accolade_total cannot find accolade_manager's grid")
    return false
}
if ds_grid_value_exists(grid,0,0,0,ds_grid_height(grid)-1,name)
{
    var row_num = ds_grid_value_y(grid,0,0,0,ds_grid_height(grid)-1,name)
    ds_grid_set(grid,col_num,row_num,val)
    return true
}
else
{
    printf("ERROR: update_accolade_total cannot find the row number for name: "+string(name))
    return false
}
