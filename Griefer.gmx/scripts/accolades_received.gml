///accolades_received()

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: accolades_received cannot find grid")
    return false
}

var len = ds_grid_height(grid)

for (var i=0; i<len; i++)
{
    if acc_row_data(i,COL_TOTAL) > 0 or acc_row_data(i,COL_BOT_TOTAL) > 0
        return true
}

return false