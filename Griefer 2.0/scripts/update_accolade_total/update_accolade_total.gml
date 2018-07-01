/// @description update_accolade_total(name, val, col, update_server)
/// @function update_accolade_total
/// @param name
/// @param  val
/// @param  col
/// @param  update_server
var name = argument0
var val = argument1
var col_num = argument2
var update_server = argument3

var stat_fl = FL_COMPETITIVE

if col_num = FL_NORMAL or col_num = FL_COMPETITIVE or col_num = COL_TOTAL
{
    stat_fl = FL_COMPETITIVE
    col_num = COL_TOTAL
}
if col_num = COL_BOT_TOTAL or col_num = FL_BOT
{
    stat_fl = FL_BOT
    col_num = COL_BOT_TOTAL
}
if col_num = COL_BOT2_TOTAL or col_num = FL_BOT2
{
    stat_fl = FL_BOT2
    col_num = COL_BOT2_TOTAL
}
if col_num = COL_BOT3_TOTAL or col_num = FL_BOT3
{
    stat_fl = FL_BOT3
    col_num = COL_BOT3_TOTAL
}
if col_num = COL_BOT4_TOTAL or col_num = FL_BOT4
{
    stat_fl = FL_BOT4
    col_num = COL_BOT4_TOTAL
}
if col_num = MATCH_TOTAL
{
    col_num = COL_MATCH_TOTAL
}

if update_server
{
    //send update to server
    printf("::: updating accolade: "+string(name)+" = "+string(val))
    if col_num
    accolade_update_real(name,val,stat_fl)
}
    
if col_num != COL_MATCH_TOTAL and col_num != COL_TOTAL and col_num != COL_BOT_TOTAL and col_num != COL_BOT2_TOTAL and col_num != COL_BOT3_TOTAL and col_num != COL_BOT4_TOTAL
{
    printf("ERROR: bad col_num passed to update_accolade_total")
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