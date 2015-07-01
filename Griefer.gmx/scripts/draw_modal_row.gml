///draw_modal_row(x, y, color, text_color, alpha, grid_y)

var xdraw = argument0
var ydraw = argument1
var col = argument2
var txt_col = argument3
var alpha = argument4
var grid_y = argument5

if not ds_exists(grid,ds_type_grid)
{
    printf("ERROR: draw_modal_row grid does not exist")
    return false
}

if not ds_grid_height(grid) > grid_y
{
    printf("ERROR: draw_modal_row indexing outside of grid")
    return false
}
    

var txt_alpha = 1

draw_set_alpha(alpha)

draw_set_color(col)
draw_rectangle(xdraw,ydraw,xdraw+width,ydraw+row_height,false)

var txt_y = ydraw+global.row_height/2

draw_set_color(txt_col)
draw_set_alpha(txt_alpha)
draw_set_halign(fa_left)
draw_set_valign(fa_center)
draw_set_font(global.table_font)

//draw the player's name and rank and whatnot
var kst = 2

//draw the columns
var dx = xdraw+global.txt_fields_start
var x_incr = (width-global.txt_fields_start)/(ds_grid_width(grid)-2)

if grid_y > 0
{
    var pname = string(ds_grid_get(grid,0,grid_y))
    var prank = real(ds_grid_get(grid,1,grid_y))
    if  pname != "" and prank != -99
        draw_namerank(pname, prank, xdraw+5, ydraw+global.row_height/4-4, global.table_namerank_scale, c_white)
}
else
{
    draw_text(xdraw+5, txt_y, "Player")
}

for (var k=kst; k < ds_grid_width(grid); k++)
{
    var cell = ds_grid_get(grid,k,grid_y)
    
    if is_string(cell)
    {
        if k < 5
            cell = string_upper(cell)
        else
            cell = capwords_super(cell)
    }
        
    draw_text(dx, txt_y, string(cell))
    dx += x_incr
}

draw_set_alpha(1)
