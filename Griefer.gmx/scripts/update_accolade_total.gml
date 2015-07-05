///update_accolade_total(name, val, flag, update_server)
var name = argument0
var val = argument1
var flag = argument2
var update_server = argument3

var col_num = 0

if flag = MATCH_TOTAL
    col_num = COL_MATCH_TOTAL
else if flag = TOTAL
{
    col_num = COL_TOTAL
    if update_server
    {
        //send update to server
        printf("::: updating accolade: "+string(name)+" = "+string(val))
        accolade_update_real(name,val,stat_manager.stat_flag)
    }
}

if not col_num
{
    printf("ERROR: neither TOTAL nor MATCH_TOTAL passed as flag to update_accolade_total")
    return false
}

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


return true
