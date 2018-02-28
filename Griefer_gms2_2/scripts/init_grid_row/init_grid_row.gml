/// @description init_grid_row(name, text, descr, image, points, needed, chal_needed, stat_flag, sound, row_num)
/// @function init_grid_row
/// @param name
/// @param  text
/// @param  descr
/// @param  image
/// @param  points
/// @param  needed
/// @param  chal_needed
/// @param  stat_flag
/// @param  sound
/// @param  row_num
var name = argument0
var text = argument1
var descr = argument2
var image = argument3
var points = argument4
var needed = argument5
var chal_needed = argument6
var stat_flag = argument7
var sound = argument8
var row_num = argument9

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: init_grid_row cannot find accolade_manager's grid")
}

ds_grid_set(grid,COL_NAME,row_num,name)
ds_grid_set(grid,COL_TEXT,row_num,text)
ds_grid_set(grid,COL_DESCR,row_num,descr)
ds_grid_set(grid,COL_IMAGE,row_num,image)
ds_grid_set(grid,COL_POINTS,row_num,points)
ds_grid_set(grid,COL_NEEDED,row_num,needed)
ds_grid_set(grid,COL_CHAL_NEEDED,row_num,chal_needed)
ds_grid_set(grid,COL_STAT_FLAG,row_num,stat_flag)
ds_grid_set(grid,COL_SOUND,row_num,sound)

printf(":::init'ing grid row for name: "+string(name))

return true