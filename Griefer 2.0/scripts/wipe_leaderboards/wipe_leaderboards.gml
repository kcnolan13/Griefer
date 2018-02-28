/// @description wipe_leaderboards
with modal_table
{
    //varWrite("create_grid",false)
    if ds_exists(grid,ds_type_grid)
    {
        ds_grid_clear(grid,0)
        ds_grid_resize(grid,ds_grid_width(grid),1)
    }

    rows_used = -1
}
