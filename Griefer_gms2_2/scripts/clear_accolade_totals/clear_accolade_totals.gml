/// @description clear_accolade_totals(flag)
/// @function clear_accolade_totals
/// @param flag
var fl = argument0
var col_num = -1

if fl = MATCH_TOTAL or fl = COL_MATCH_TOTAL
    col_num = COL_MATCH_TOTAL
else if fl = TOTAL or fl = COL_TOTAL
    col_num = COL_TOTAL
else if fl = COL_BOT_TOTAL
    col_num = COL_BOT_TOTAL
else
{
    printf("Error: bad flag passed to clear_accolade_totals: "+string(fl))
    return false
}

var grid = accolade_manager.grid

if ds_exists(grid,ds_type_grid)
    {
        for (var i=0; i < ds_grid_height(grid); i++)
        {
            if i >= ds_grid_height(grid)
            {
                printf("ERROR: clear_accolade_totals indexing out of grid")
                break
            }
            ds_grid_set(grid,col_num,i,0)
        }
    }
    else
    {
        printf("ERROR: accolade_manager room_start can't find grid")
    }
