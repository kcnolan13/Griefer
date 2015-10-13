///accolades_received()

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: accolades_received cannot find grid")
    return false
}

var len = ds_grid_height(grid)

var col_total = COL_TOTAL
if stat_manager.stat_tab = stat_manager.tabs[1]
    col_total = COL_BOT_TOTAL

for (var i=0; i<len; i++)
{
    if acc_row_data(i,col_total) > 0
        return true
}

return false
