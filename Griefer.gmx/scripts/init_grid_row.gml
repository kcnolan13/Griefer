///init_grid_row(name, text, descr, image, points, row_num)
var name = argument0
var text = argument1
var descr = argument2
var image = argument3
var points = argument4
var row_num = argument5

var grid = accolade_manager.grid

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: init_grid_row cannot find accolade_manager's grid")
}
ds_grid_set(grid,0,row_num,name)
ds_grid_set(grid,1,row_num,text)
ds_grid_set(grid,2,row_num,descr)
ds_grid_set(grid,3,row_num,image)
ds_grid_set(grid,4,row_num,points)


return true
