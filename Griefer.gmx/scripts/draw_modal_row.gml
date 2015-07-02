///draw_modal_row(x, y, color, text_color, alpha, grid_y, dgrid)

var xdraw = argument0
var ydraw = argument1
var col = argument2
var txt_col = argument3
var alpha = argument4
var grid_y = argument5
var dgrid = argument6
    
if not ds_exists(dgrid,ds_type_grid)
{
    printf("ERROR: draw_modal_row dgrid does not exist")
    return false
}

if not ds_grid_height(dgrid) > grid_y
{
    printf("ERROR: draw_modal_row indexing outside of dgrid")
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
var x_incr = (width-global.txt_fields_start)/(ds_grid_width(dgrid)-2)

if dgrid != grid_header
{
    var pname = string(ds_grid_get(dgrid,0,grid_y))
    var prank = real(ds_grid_get(dgrid,1,grid_y))
  
    if  pname != "" and prank != -99
        draw_namerank(pname, prank, xdraw+5, ydraw+global.row_height/4-4, global.table_namerank_scale, c_white)
}
else
{
    draw_text(xdraw+5, txt_y, "Player")
    if dgrid = grid_header
    {
        //column highlighting
        var col_high = sort_col_highlighted()
        if col_high > -1
        {
            draw_set_color(c_gray)
            draw_rectangle(dx+x_incr*(col_high-2),ydraw,dx+x_incr*(col_high-1),ydraw+row_height,false)
            draw_set_color(txt_col)
        }
    }
}

for (var k=kst; k < ds_grid_width(dgrid); k++)
{
    var cell = ds_grid_get(dgrid,k,grid_y)
    
    if is_string(cell)
    {
        if k < 5
        {
            cell = string_upper(cell)
        }
        else
            cell = capwords_super(cell)
    }
        
    draw_text(dx, txt_y, string(cell))

    dx += x_incr

}

//draw the row number
if dgrid = grid
{
    draw_set_color(c_black)
    draw_set_halign(fa_right)
    draw_text(xdraw-10,ydraw+row_height/2,string(grid_y+1))
}

draw_set_alpha(1)
